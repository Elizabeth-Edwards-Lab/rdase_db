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

            if identity_group.include? s_identity
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

  # self-defined data structure
  def collection(header,status,msg,group=nil)
    collection_hash = { :header => header, :status => status, :msg => msg, :group => group }
  end

  # Basic Logic:
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
  # TODO: add the new group situation
  #  @aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f
  # For new group:
  # if your sequence shares greater than or equal to 90% pairwise ID are the amino acid level to a current 
  # RdhA database sequence, but if the sequence is NOT 90% identical to any 
  # members of X group in amino acids level (not all of them); then and if the sequence is also NOT 90% 
  # identical to any members of X group in gene level, this sequence DOES NOT belongs to X group; then 
  # create a new group. 
  def sequence_check_for_submission(sequence,group_hash,reversed_group_hash)

    result_array = Array.new
    aa_threshold = 0.9
    
    begin

      
      query = Bio::FastaFormat.new( sequence )
      query_name = query.definition
      sequence = query.to_seq

      existing_matched_group_exist = CustomizedProteinSequence.find_by(:chain => sequence.seq)
      if !existing_matched_group_exist.nil? # find existing sequence
        result_array << collection(query_name, "WARN", "Matching #{existing_matched_group_exist.header}")
        return result_array
      end

      sequence.auto # Guess the type of sequence. Changes the class of sequence.
      query_sequence_type = sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'

      program = 'blastp'
      database = 'reductive_dehalogenase_protein'
      blast_options = get_blast_options


      blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
      aa_report = blaster.query(sequence.seq) # sequence.seq automatically remove the \n; possibly other wildcard
      aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f
      identity_with_90 = check_alignment_identity(aa_report, 90)

      # group_hash => group : Array {seq_definition}
      # reversed_group_hash = seq_definition : group
      if identity_with_90.length > 0
        # group_hash, reversed_group_hash = get_group_sequence_table
        identified_group_at_aa_level = get_identified_group(identity_with_90,group_hash,reversed_group_hash)
      else
        # add the new group selection criteria
        if aa_similarity >= aa_threshold
          last_group = CustomizedProteinSequence.group(:group).order(:group).last.group
          new_group_number = last_group + 1
          result_array << collection(query_name,"NEW", "Your sequence belongs to a new RD group: #{new_group_number}",new_group_number)
        else

          result_array << collection(query_name, "FAILED","Your sequence doesn't share 90\% of any sequences in database at amino acid level.")
        end

        return result_array
      end

      if identified_group_at_aa_level.length > 0
        final_identified_group = get_final_identified_group(sequence.seq,identified_group_at_aa_level,group_hash)
      else
        result_array << collection(query_name, "FAILED","Your sequence doesn't share 90\% of representatives of the group at amino acid level.")
        return result_array
      end

      if final_identified_group.length > 0
        result_array << collection(query_name, "SUCCESS","Your sequence belongs RD group: #{final_identified_group.join(",")}",final_identified_group.join(","))
      else
        result_array << collection(query_name, "FAILED","Your sequence shares 90\% of representatives of the group at amino acid level; but not at nt level.")
        return result_array
      end

      
    rescue => exception
      # puts exception
      result_array << collection(query_name, "ERROR","Your sequence is not validated. Or send it to our lab for manual checking.")
    end
    
    return result_array

  end



  def submit_sequence_caller(fasta_array)

    uploading_result = Array.new
    group_hash, reversed_group_hash = get_group_sequence_table
    fasta_array.each do |fasta_seq|

      # check if the sequence is already in database
      result = sequence_check_for_submission(fasta_seq,group_hash,reversed_group_hash)
      # TODO: if result is successful, add the seq to file
      uploading_result.push(*result)

    end
    # add file location at the end, and pop the last items at controller
    return uploading_result
  end


  def save_result_to_db(result_array,fasta_array,uploader_name, uploader_email)

    fasta_hash = Hash.new
    fasta_array.each do |fasta_sequence|
      query = Bio::FastaFormat.new( fasta_sequence )
      fasta_hash[query.definition] = query.to_seq.seq
    end

    result_array.each do |result|
      header = result[:header]
      status = result[:status]
      if result[:status] == "SUCCESS"
        begin
          # save to database
          groups = result[:group].split(",") # likely only have one group. so if more than one group, save them separately 
          groups.each do |gp|
            
            new_sequence = CustomizedProteinSequence.new
            new_sequence.header = result[:header]
            new_sequence.uploader = "USER"
            new_sequence.uploader_name = uploader_name
            new_sequence.uploader_email = uploader_email
            new_sequence.group = gp
            new_sequence.accession_no = result[:header] # result[:header] should be accession no OR manually extract accession number from local blast db
            new_sequence.chain = fasta_hash[result[:header]]
            new_sequence.save!


          end
        rescue => exception
          puts exception
          return false
        end
       

      end

    end

    return true

  end

  def construct_new_blast_db


    # what about gene database??? 
    # ask user to submit gene sequence as well?
    # How about only add user's amino acid sequence to database, but not constructing the blast_db;
    # which blast_db should be construct at certain period of time after the sequence has been fully annotated by our lab
    # make this as notification for all users
    # The key point of the db is for people to annotate their sequence against our databases; also for educating people what is RD and their groups



  end


  def send_sequence_to_lab_without_validation(sequence,requester,requester_email,institution=nil,publications=nil,organism=nil)
    
    body = "<div>#{sequence}</div>
            <div>
              <p>requester: #{requester}</p>
              <p>requester email: #{requester_email}</p>
              <p>requester institution: #{institution}</p>
              <p>requester publications: #{publications}</p>
              <p>sequence organism: #{organism}</p>
            </div>"

    ActionMailer::Base.mail(from: "me@example.com", to: "xcao2@ualberta.ca", subject: "New Submission Request (Orthdb)", body: body).deliver
  end


end


























