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
  # c. (if b is yes) confirm with nt/gene level => this check has been removed based on meeting on 2019-10-28
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
        result_array << collection(query_name, "WARN", "Your sequence exists in our database. Common Name: #{existing_matched_group_exist.header} ")
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
      identity_with_90 = get_identity_with_90(aa_report)  # identity_with_90 contains all the header that share >=90% identity

      # group_hash => group : Array {seq_definition}
      # reversed_group_hash = seq_definition : group
      if identity_with_90.length > 0
        identified_group_at_aa_level = get_identified_group(identity_with_90,group_hash,reversed_group_hash) # identified_group_at_aa_level contains confirmed group in aa level      
      else
        # if identity_with_90.length == 0; no RD with ~=90% identity => create new RD groups

        if aa_similarity >= aa_threshold
          last_group = CustomizedProteinSequence.group(:group).order(:group).last.group
          new_group_number = last_group + 1
          result_array << collection(query_name,"NEW", "Your sequence belongs to a new RD group: #{new_group_number}",new_group_number)
        else
          result_array << collection(query_name, "FAILED","Your sequence doesn't share 90\% identity of any sequences in database at amino acid level.")
        end

        return result_array
      end

      if identified_group_at_aa_level.length > 0
        result_array << collection(query_name, "SUCCESS","Your sequence belongs RD group: #{identified_group_at_aa_level.join(",")}",identified_group_at_aa_level.join(","))
      else
        result_array << collection(query_name, "FAILED","Your sequence doesn't share 90\% identity with all representatives of the group at amino acid level.")
      end

      return result_array
      
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
      result = sequence_check_for_submission(fasta_seq,group_hash,reversed_group_hash)
      uploading_result.push(*result)
    end
    # add file location at the end, and pop the last items at controller
    # uploading_result[0]["status"] = "SUCCESS"
    return uploading_result
  end


  def save_result_to_db(result_array,fasta_array,uploader_name,uploader_email)

    fasta_hash = Hash.new
    fasta_array.each do |fasta_sequence|
      query = Bio::FastaFormat.new( fasta_sequence )
      fasta_hash[query.definition] = query.to_seq.seq
    end

    result_array.each do |result|
      
      begin
        # save to database; only for those will have either existing group or new group number
        # the result_array is json, not ruby hash
        if result["status"] == "SUCCESS" or result["status"] == "NEW" #only store successful sequence
          if result["group"].present?

            groups = result["group"].split(",") # likely only have one group. so if more than one group, save them separately 
            groups.each do |gp|
              puts "groups => #{gp}"
              new_sequence = CustomizedProteinSequence.new
              new_sequence.header = result["header"]
              new_sequence.uploader = "Public"
              new_sequence.uploader_name = uploader_name
              new_sequence.uploader_email = uploader_email
              new_sequence.group = gp
              new_sequence.accession_no = result["header"] # result[:header] should be accession no OR manually extract accession number from local blast db
              new_sequence.chain = fasta_hash[result["header"]]
              new_sequence.save!


              # don't ask user for nt sequence yet. probably ask later through email
              new_nt_sequence = CustomizedNucleotideSequence.new
              new_nt_sequence.header = result["header"]
              new_nt_sequence.uploader = "Public"
              new_nt_sequence.uploader_name = uploader_name
              new_nt_sequence.uploader_email = uploader_email
              new_nt_sequence.group = gp
              new_nt_sequence.accession_no = result["header"]
              new_nt_sequence.save!

            end
          end
        end

      rescue => exception
        puts exception
        return false
      end

    end

    return true

  end




  # below are new code for submission engine 
  def collection_v2(header,accession_no,organism,status,msg,group,reference)
    collection_hash = { :header => header, :accession_no => accession_no, 
      :organism => organism, :status => status, :msg => msg, :group => group,
      :reference => reference }
  end

  def annotation_submission(sequence,group_hash,reversed_group_hash)

    result_array = Array.new
    aa_threshold = 0.9
    
    # at this point, the fasta format should be standard; any failed processing should be caught at validation_submission part
    query = Bio::FastaFormat.new( sequence )

    definition = query.definition.split("|")

    header_info    = definition[0].strip
    accession_no   = definition[1].strip
    organism       = definition[2].strip
    reference      = definition[3]
    sequence       = query.to_seq

    existing_matched_group_exist = CustomizedProteinSequence.find_by(:chain => sequence.seq)
    if !existing_matched_group_exist.nil? # find existing sequence
      result_array << collection_v2(header_info, accession_no, organism, "WARN", "Matching #{existing_matched_group_exist.header}", nil, reference)
      return result_array
    end

    sequence.auto # Guess the type of sequence. Changes the class of sequence.
    query_sequence_type = sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
    blaster = Bio::Blast.local( 'blastp', "#{Rails.root}/index/blast/reductive_dehalogenase_protein", get_blast_options)
    
    aa_report = blaster.query(sequence.seq) # sequence.seq automatically remove the \n; possibly other wildcard
    aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f
    identity_with_90 = get_identity_with_90(aa_report)  # identity_with_90 contains all the header that share >=90% identity

    # group_hash => group : Array {seq_definition}
    # reversed_group_hash = seq_definition : group
    if identity_with_90.length > 0
      identified_group_at_aa_level = get_identified_group(identity_with_90,group_hash,reversed_group_hash) # identified_group_at_aa_level contains confirmed group in aa level      
    else
      if aa_similarity >= aa_threshold
        last_group = CustomizedProteinSequence.group(:group).order(:group).last.group
        new_group_number = last_group + 1
        result_array << collection_v2(header_info, accession_no, organism, "NEW", "Your sequence belongs to a new OG group: #{new_group_number}",new_group_number, reference)
      else
        result_array << collection_v2(header_info, accession_no, organism, "FAILED","Your sequence doesn't share 90\% identity of any sequences in database at amino acid level.", nil, reference)
      end

      return result_array
    end

    if identified_group_at_aa_level.length > 0
      result_array << collection_v2(header_info, accession_no, organism, "SUCCESS","Your sequence belongs to OG group: #{identified_group_at_aa_level.join(",")}",identified_group_at_aa_level.join(","), reference)
    else
      result_array << collection_v2(header_info, accession_no, organism, "FAILED","Your sequence doesn't share 90\% identity with all representatives of the group at amino acid level.",nil, reference)
    end

    return result_array

  end

  # at this point, the sequence should be perfect; then, that's the issue of validation
  def save_success_sequence(aa_sequence, nt_sequence, header, accession_no, organism, group, reference, uploader_name, uploader_email)

    new_sequence = CustomizedProteinSequence.new
    new_sequence.header         = header
    new_sequence.uploader       = "Public"
    new_sequence.uploader_name  = uploader_name
    new_sequence.uploader_email = uploader_email
    new_sequence.group          = group
    new_sequence.accession_no   = accession_no # result[:header] should be accession no OR manually extract accession number from local blast db
    new_sequence.chain          = aa_sequence
    new_sequence.reference      = reference
    new_sequence.save!


    # don't ask user for nt sequence yet. probably ask later through email
    new_nt_sequence = CustomizedNucleotideSequence.new
    new_nt_sequence.header         = header
    new_nt_sequence.uploader       = "Public"
    new_nt_sequence.uploader_name  = uploader_name
    new_nt_sequence.uploader_email = uploader_email
    new_nt_sequence.group          = group
    new_nt_sequence.accession_no   = accession_no
    new_nt_sequence.chain          = nt_sequence
    new_sequence.reference         = reference
    new_nt_sequence.save!


  end


  # aa_fasta_array[header] => aa_sequence; same as nt_fasta_array
  # at this point, the aa_fasta and nt_fasta should be perfect, otherwise, something wrong with validation
  def submit_sequence_caller_for_aa_nt(aa_fasta_array, nt_fasta_array,uploader_name, uploader_email)
    
    uploading_result = Array.new
    group_hash, reversed_group_hash = get_group_sequence_table
    aa_fasta_array.each do |fasta_seq|
      result = annotation_submission(fasta_seq,group_hash,reversed_group_hash)
      uploading_result.push(*result)
    end

    aa_fasta_hash = convert_fasta_array_to_hash(aa_fasta_array)
    nt_fasta_hash = convert_fasta_array_to_hash(nt_fasta_array)
    # puts aa_fasta_hash

    # collection_hash = { :header => header, :accession_no => accession_no, 
      # :organism => organism, :status => status, :msg => msg, :group => group,
      # :reference => reference }

    # puts "test submit_sequence_caller_for_aa_nt"
    # uploading_result.each do |row|
    #   puts row.inspect
    # end

    # add the successful sequence to database   
    # aa_fasta_array is array not hash 
    uploading_result.each do |submission|
      header = submission[:header]
      accession_no = submission[:accession_no]
      organism = submission[:organism]
      status = submission[:status]
      group  = submission[:group]
      reference = submission[:reference]
      # group = "1"
      # status = "SUCCESS"
      if status == "SUCCESS" or status == "NEW"
        group.split(",").each do |g|
          save_success_sequence(aa_fasta_hash[header], nt_fasta_hash[header], g , accession_no, organism, g, reference, uploader_name, uploader_email)
        end
      end

    end

    return uploading_result

  end


  # fasta array comes from scan('[\>]')
  def convert_fasta_array_to_hash(fasta_array)
    fasta_hash = Hash.new

    fasta_array.each do |fasta_sequence|
      query = Bio::FastaFormat.new( fasta_sequence )
      aa_sequence_definition = parse_definition(query.definition)
      fasta_hash[aa_sequence_definition[0].strip] = query.to_seq.seq
    end

    return fasta_hash
  end


  # TODO: still need to validate the DNA to RNA
          # validate the correctness of assession number
  # to test concern in console
  # controller = ActionController::Base::ApplicationController.new
  # controller.extend(MyConcern)
  # controller.concern_method "hello world"
  # return possible_errors, if possible_errors.length > 0 means there are something wrong
  def validation_submission(params)

    possible_errors = Array.new

    aa_seq_array = is_sequence_empty(params[:aa_sequence], params[:aa_fasta])
    puts "aa_seq_array => #{aa_seq_array}"
    # if user submit more than 20 sequence at time, return error immediately
    if !aa_seq_array.nil? and aa_seq_array.length > 20
      possible_errors << "You submitted more than 20 amino acid sequences. While, we only accept 20 amino acid sequences or less per submission."
      return possible_errors
    end

    nt_seq_array = is_sequence_empty(params[:nt_sequence], params[:nt_fasta])
    puts "nt_seq_array => #{nt_seq_array}"
    if !nt_seq_array.nil? and nt_seq_array.length > 20
      possible_errors << "You submitted more than 20 nucleotide sequences. While, we only accept 20 nucleotide sequences or less per submission."
      return possible_errors
    end


    if aa_seq_array.nil? or nt_seq_array.nil?
      possible_errors << "Either your amino acid sequence or nucleotide sequence are empty"
      return possible_errors
    end

    # Check aa sequence 
    aa_sequence_hash = Hash.new
    header_array = Array.new
    accession_no_array = Array.new
    invalid_definition = ""
    invalid_sequence = ""
    aa_seq_array.each do |fasta_sequence|
      query = Bio::FastaFormat.new( fasta_sequence )
      aa_sequence_definition = parse_definition(query.definition)

      aa_sequence = validate_seq(query.to_seq.seq,"aa") # fail return nil; success return 0
      # puts "validation aa_sequence => #{aa_sequence}"
      if aa_sequence_definition.nil?
        invalid_definition += "#{query.definition}\n"
      end

      if aa_sequence.nil?
        invalid_sequence += "#{query.definition}\n"
      end

      if !aa_sequence_definition.nil? and !aa_sequence.nil?
        aa_sequence_hash[aa_sequence_definition[0]] = query.to_seq.seq

        header_array << aa_sequence_definition[0].strip
        accession_no_array << aa_sequence_definition[1].strip
      end
      
    end
    
    if invalid_definition.length > 0 or invalid_sequence.length > 0
      # something wrong with aa sequence field
      invalid_submission_msg = "Your following amino acid sequences are not following our submission rules\n"
      if invalid_definition.length > 0
        invalid_submission_msg += "Failed fasta format:\n #{invalid_definition}"
      end
      if invalid_sequence.length > 0
        invalid_submission_msg += "Failed amino acid sequence:\n #{invalid_sequence}"
      end

      possible_errors << invalid_submission_msg

      return possible_errors

    end

    # check uniqueness of header
    duplicate_header = check_uniqueness_of_header(header_array)
    if duplicate_header.length != 0
      invalid_submission_msg = "Your following amino acid sequences have duplicate header:\n"
      duplicate_header.each do |d_header|
        invalid_submission_msg += "#{d_header}\n"
      end

      possible_errors << invalid_submission_msg
      
      return possible_errors
    end

    # check if the accession number is validate or not
    # we only check the correctness of aa accession number; not gene; since we only care one accession number
    invalid_accession_num = validate_accession_numbers(accession_no_array, "aa")
    if invalid_accession_num.length != 0
      invalid_submission_msg = "Your following amino acid sequences have invalid accession number from NCBI. Please check NCBI protein database:<br>"
      invalid_accession_num.each do |accession_no|
        invalid_submission_msg += "#{accession_no}<br>"
      end

      possible_errors << invalid_submission_msg
      
      return possible_errors
    end

    ########################################################################################
    # Check nt sequence
    nt_sequence_hash = Hash.new
    header_array = Array.new
    accession_no_array = Array.new
    invalid_definition = ""
    invalid_sequence = ""
    nt_seq_array.each do |fasta_sequence|
      query = Bio::FastaFormat.new( fasta_sequence )
      nt_sequence_definition = parse_definition(query.definition)
      nt_sequence = validate_seq(query.to_seq.seq,"nt")
      
      # puts "validation nt_sequence => #{nt_sequence}"
      if nt_sequence_definition.nil?
        invalid_definition += "#{query.definition}\n"
      end

      if nt_sequence.nil?
        invalid_sequence += "#{query.definition}\n"
      end

      if !nt_sequence_definition.nil? and !nt_sequence.nil?
        nt_sequence_hash[nt_sequence_definition[0]] = query.to_seq.seq

        header_array << nt_sequence_definition[0].strip
        accession_no_array << nt_sequence_definition[1].strip
      end
    end

    if invalid_definition.length > 0 or invalid_sequence.length > 0
      # something wrong with aa sequence field
      invalid_submission_msg = "Your following nucleotide sequences are not following our submission rules"
      if invalid_definition.length > 0
        invalid_submission_msg += "Failed fasta format:\n #{invalid_definition}"
      end
      if invalid_sequence.length > 0
        invalid_submission_msg += "Failed nucleotide sequence:\n #{invalid_sequence}"
      end

      possible_errors << invalid_submission_msg
      return possible_errors
    end
    
    duplicate_header = check_uniqueness_of_header(header_array)
    if duplicate_header.length != 0
      invalid_submission_msg = "Your following nucleotide sequences have duplicate header:\n"
      duplicate_header.each do |d_header|
        invalid_submission_msg += "#{d_header}\n"
      end
      
      possible_errors << invalid_submission_msg
      
      return possible_errors
    end

    invalid_accession_num = validate_accession_numbers(accession_no_array, "nt")
    if invalid_accession_num.length != 0
      invalid_submission_msg = "Your following nucleotide sequences have invalid accession number from NCBI. Please check NCBI protein database:<br>"
      invalid_accession_num.each do |accession_no|
        invalid_submission_msg += "#{accession_no}<br>"
      end

      possible_errors << invalid_submission_msg
      
      return possible_errors
    end



    # check missing sequence
    missing_aa_sequence, missing_nt_sequence = check_matchness(aa_sequence_hash,nt_sequence_hash)
    # puts "missing_aa_sequence => #{missing_aa_sequence}"
    # puts "missing_nt_sequence => #{missing_nt_sequence}"
    missing_seq_string = ""
    if missing_aa_sequence.length > 0
      missing_seq_string += "You are missing following amino acid sequence based on your nucleotide sequence:\n"
      missing_aa_sequence.each do |aa_seq_name|
        missing_seq_string += "#{aa_seq_name}\n"
      end
    end

    if missing_nt_sequence.length > 0
      missing_seq_string += "You are missing following nucleotide sequence based on your amino acid sequence:\n"
      missing_nt_sequence.each do |nt_seq_name|
        missing_seq_string += "#{nt_seq_name}\n"
      end
    end

    if missing_seq_string.length > 0
      possible_errors << missing_seq_string
    end



    # if error, return error
    # else, return aa_array and nt_array 
    if possible_errors.length > 0
      return possible_errors
    else
      aa_nt_array = Hash.new
      aa_nt_array["aa"] = aa_seq_array
      aa_nt_array["nt"] = nt_seq_array
      return aa_nt_array
    end

  end


  # check the matches of the sequences
  def check_matchness(aa_sequence_hash,nt_sequence_hash)
    missing_nt_sequence = Array.new
    aa_sequence_hash.each do |defi, seq|
      if nt_sequence_hash[defi].nil? 
        # miss that stuff
        missing_nt_sequence << defi
      end
    end

    missing_aa_sequence = Array.new
    nt_sequence_hash.each do |defi, seq|
      if aa_sequence_hash[defi].nil?
        missing_aa_sequence << defi
      end
    end


    return missing_aa_sequence, missing_nt_sequence
  end


  # Test: Working
  def is_sequence_empty(sequence, fasta_file)
    empty_seq = true
    fasta_array = nil
    begin 
      fasta_array = sequence.scan(/>[^>]*/)
      if fasta_array.length != 0
        empty_seq = false
      end
    rescue
      # enter this point: sequence text area field is empty or nil
      # note: fasta_file = params[:fasta]
      begin
        fasta_array = fasta_file.tempfile.read.scan(/>[^>]*/)
        if fasta_array.length != 0
          empty_seq = false
        end
      rescue
        # fasta_file is nil so equence text area field is empty or nil and fasta_file is empty or nil
        empty_seq = true
      end
    end

    if empty_seq == true
      return nil
    else
      return fasta_array
    end

  end


  # more than one headers have same name is not allowed
  def check_uniqueness_of_header(header_array)
    uniqueness = Array.new
    duplicates = Array.new

    header_array.each do |header|
      if uniqueness.include? header
        duplicates << header
      else
        uniqueness << header
      end
    end

    return duplicates.uniq

  end
  
  def parse_definition(definition)

    definition = definition.split("|")
    if definition.length == 3 or definition.length == 4
      # check the validation of accession number 
      # If you want to remove only leading and trailing whitespace (like PHP's trim) you can use .strip, but if you want to remove all whitespace, you can use .gsub(/\s+/, "") instead .
      definition[0] = definition[0].strip
      definition[1] = definition[1].strip
      definition[2] = definition[2].strip

      return definition
    else
      return nil
    end

  end




  def validate_accession_numbers(accession_no_array, seq_type)

    invalid_accession_num = Array.new
    accession_no_array.each do |accession_no|

      if validate_accession_number(accession_no, seq_type) == false
        invalid_accession_num << accession_no
      end

    end

    return invalid_accession_num
  end

  # return false if accession number is invalid
  def validate_accession_number(accession_no,seq_type)
    is_valid_accession_no = false
    # https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=protein&id=AEE34859.1&api_key=e2eded7b94c28c0734a03b44d4a2d5a15308
    # check NCBI. to determine the accession_no is correct, grap the origin aa sequence and compare
    # documents about ncbi api
    # https://www.ncbi.nlm.nih.gov/books/NBK25500/#_chapter1_Downloading_Document_Summaries_
    # https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?&api_key=db1a6c70014467857721f83996c2c9d4a207&db=protein&id=AEE34859.1
    api_key = "db1a6c70014467857721f83996c2c9d4a207"
    ncbi_api = nil
    if seq_type == "aa"
      ncbi_api = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?api_key=#{api_key}&db=protein&id=#{accession_no}"
    elsif seq_type == "nt"
      # ncbi_api = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/epost.fcgi?api_key=#{api_key}&db=nuccore&id=#{accession_no}"
      # TODO accession_no validation for nucleotide / locus tag
      return true
    end

    ncbi_res = open(ncbi_api) # StringIO object
    if ncbi_res.status.include? "200"
      doc = Nokogiri::XML(ncbi_res.read)
      if doc.xpath('//ERROR').length == 0

        is_valid_accession_no = true

      end
    end

    return is_valid_accession_no

  end

  
  def validate_seq(sequence, seq_type)

    if seq_type == "aa"
      va = sequence =~ /\A[*GAVLIMFWPSTCYNQDEKRHXBZUOJ]+\z/
    end

    if seq_type == "nt"
      va = sequence =~ /\A[ACTGN]+\z/
    end

    return va
  end

end

