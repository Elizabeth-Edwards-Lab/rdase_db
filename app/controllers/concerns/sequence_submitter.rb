module SequenceSubmitter
  extend ActiveSupport::Concern

  def get_blast_options
    # set the default blast parameter
    # no params[:lower_case_filtering]; params[:filter_query_sequence]; params[:gapped_alignment];
    evalue = 0.000001
    cost_to_open_a_gap = 11
    cost_to_extend_a_gap = 1
    # penalty_for_mismatch = -3
    # reward_for_match = 2
    lower_case_filtering = 'T'
    filter_query_sequence = 'F'
    gapped_alignment = 'T'
    blast_options = { 'e' => evalue.to_f, 
                    'G' => cost_to_open_a_gap.to_i,
                    'E' => cost_to_extend_a_gap.to_i,
                    'U' => lower_case_filtering, 
                    'F' => filter_query_sequence,
                    'g' => gapped_alignment }
    
    blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")

    return blast_options

  end


  def check_alignment_identity(report, threshold)
    # check identity with 90 
    identity_with_90 = Array.new 
    report.each do |hit|

      match_identity = hit.identity.to_f / hit.query_len.to_f * 100 

      if match_identity >= threshold
        identity_with_90 << hit.target_def
      end

    end

    return identity_with_90
  end



  def get_group_sequence_table
    protein_sequence = CustomizedProteinSequence.all
    group_hash = Hash.new
    reversed_group_hash = Hash.new
    protein_sequence.each do |single_entry|

      if single_entry.group.nil?
        next
      else
        # create the dictionary as sequence : group number
        # create the dictionary as group number : sequence
        reversed_group_hash[single_entry.header] = single_entry.group
        if group_hash[single_entry.group].nil?
          group_array = Array.new
          group_array << single_entry.header
          group_hash[single_entry.group] = group_array
        else

          group_hash[single_entry.group] << single_entry.header

        end
      end

    end 

    return group_hash, reversed_group_hash

  end


  # This function check if the sequence matched group also match all representitives  of that group
  # identified_groups should contain the eligiable group number
  # should only return one group; if more than one group, should be suspicious
  def get_identified_group(identity_group,group_hash,reversed_group_hash)
    
    identified_group = Array.new 

    identity_group.each do |definition|
      group_number = reversed_group_hash[definition]

      if !group_number.blank? && !group_number.nil?
        is_belong_to_group = true

        if group_hash[group_number].length == 1

          is_belong_to_group = true

        else 

          group_hash[group_number].each do |s_identity|

            if identity_with_90.include? s_identity
              next
            else
              is_belong_to_group = false
            end

          end
        end 

        if is_belong_to_group == true
          if !identified_group.include? group_number
            identified_group << group_number
          end
        end 

      end 

    end # end of each loop

    return identified_group

  end


  def check_alignment_identity_at_nt_level(aa_sequence,database,threshold) 

    blast_options = { 'e' => 0.10 }
    blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
    blaster = Bio::Blast.local('tblastn', "#{Rails.root}/index/blast/#{database}",blast_options)
    nt_report = blaster.query(aa_sequence)

    dna_level_hit_90 = Array.new
    nt_report.each do |hit|
      match_identity = hit.identity.to_f / hit.query_len.to_f * 100
      if match_identity >= threshold
        dna_level_hit_90 << hit.target_def  
      end
    end

    return dna_level_hit_90

  end

  # This function check the group in gene level
  # aa_sequence => original user input sequence
  # identity_group => Array contains previous identified group
  def get_final_identified_group(aa_sequence,identity_group,group_hash)
    final_identified_group = Array.new # this is final check for the similarity
    dna_level_hit_90 = check_alignment_identity_at_nt_level(aa_sequence,"reductive_dehalogenase_gene", 90)  # check for the sequence that hit level 90

    if dna_level_hit_90.length > 0
      identity_group.each do |group_number|
        final_check_pass = true
        nt_definition_array = group_hash[group_number]
        if nt_definition_array.length == 1
          if dna_level_hit_90.include? nt_definition_array[0]
            final_check_pass = true
          end
        else # nt_definition_array.length > 1
          nt_definition_array.each do |nt_definition|
            if dna_level_hit_90.include? nt_definition
              next
            else
              final_check_pass = false
            end
          end
        end

        if final_check_pass == true
          final_identified_group << group_number
        end
      end # end of identity_groups.each do |group_number|
    end

    return final_identified_group
  end

  # Basic Logic:
  # Note: we assume the sequence is after check if the sequence already in the database (from controller)
  # Do blastp
  # a.check if there any sequence in the database share more than 90% of identity with query sequence
  #   if yes: grap all the groups and confirm that it matches all representive of that group by 90%
  #   if no: return the result as: doesn't share any 90% with any sequence in database
  # b. (if a is yes) check if all representitive share 90% percentage
  #   if yes: confirm with nt/gene level
  #   if no: return the result as: not all representive of the group share 90% of database
  # c. (if b is yes) confirm with nt/gene level
  #   if yes: return the group number and add the sequence to database if user has the accession number
  #   if no: return the result as: it shares representive of the group share 90% of database at aa level, but not at nt level.

  def sequence_check_for_submission(sequence)

    result = Hash.new
    query = Bio::FastaFormat.new( sequence )
    query_name = query.definition
    sequence = query.to_seq
    sequence.auto # Guess the type of sequence. Changes the class of sequence.

    query_sequence_type = sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'

    program = 'blastp'
    database = 'reductive_dehalogenase_protein'
    blast_options = get_blast_options

    begin
      blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
      aa_report = blaster.query(sequence.seq) # sequence.seq automatically remove the \n; possibly other wildcard
      identity_with_90 = check_alignment_identity(aa_report, 90)

      # group_hash => group : Array {seq_definition}
      # reversed_group_hash = seq_definition : group
      if identity_with_90.length > 0
        group_hash, reversed_group_hash = get_group_sequence_table
        identified_group_at_aa_level = get_identified_groups(identity_with_90,group_hash,reversed_group_hash)
      else
        result["FAILED"] = "Your sequence doesn't share 90\% of any sequences in database at aa level."
        return result
      end

      if identified_group_at_aa_level.length > 0
        final_identified_group = get_final_identified_group(sequence.seq,identified_group_at_aa_level,group_hash)
      else
        result["FAILED"] = "Your sequence doesn't share 90\% of representatives of the group at aa level."
        return result
      end

      if final_identified_group.length > 0
        result["SUCCESS"] = final_identified_group
      else
        result["FAILED"] = "Your sequence shares 90\% of representatives of the group at aa level; but not at nt level."
        return result
      end

      
    rescue
      result["ERROR"] = "Your sequence is not validated. Or send it to our lab for manual checking."
    end

    
    return result



  end
end


























