class QueryController < ApplicationController
  # include concerns
  include QueryLogic
  include QueryValidator # concerns is for reducing logic in controller
  include TreeBuilder
  helper QueryHelper # helper is for reducing logic in view



	before_action :set_blast_defaults_for_aa
  

  def search

    # puts "params.inspect => #{params.inspect}"
    if params[:notice].present?
      @error = params[:notice]
    end

    # params.inspect
    params[:filters] ||= {}

    if params[:commit].present?

      if params[:sequence].present?

        # do validation first to make sure the the sequence is ok for blasting
        # then save to query, and send the query id to other actions
        # for the query, make sure the sequenece is delievered properly
        
        # if the sequence is not match /^>/; return true and do making-up
        params_sequence = params[:sequence].clone
        after_validation = validate_amino_acid_sequnence(params_sequence)
        if after_validation.class == String
          params[:sequence] = after_validation
        elsif after_validation.class == Hash
          error_msg = ""
          after_validation.each do |key, error|
            error_msg += "#{error}\n"
          end
          redirect_to :controller => 'query', :action => 'search', params: params.merge(:notice => error_msg ).permit(:notice) and return
        end

      else
        redirect_to :controller => 'query', :action => 'search', params: params.merge(:notice => "Must provide an amino acid sequence in Fasta format").permit(:notice) and return
      end

      fasta_array = params[:sequence].scan(/>[^>]*/)
      # only allow one sequence at time on server
      if fasta_array.length > 1
        redirect_to :controller => 'query', :action => 'search', params: params.merge(:notice => "Please provide only one sequence.").permit(:notice) and return
      end

      # TODO: limit one sequence to send to new tab
      if params[:new_result_tab] == "1"
        # consider render status (for animation) first, then render the result to result page
        redirect_to :controller => 'query', :action => 'result', params: params.merge(:sequence => fasta_array[0],
          :gap_cost => params[:gap_cost], :extend_cost => params[:extend_cost],:mismatch_penalty => params[:mismatch_penalty],
          :match_reward => params[:match_reward], :evalue => params[:evalue], :gapped_alignment => params[:gapped_alignment],
          :filter_query_sequence => params[:filter_query_sequence],:commit => params[:commit]).permit(:sequence, :gap_cost, :extend_cost, 
          :mismatch_penalty, :match_reward, :evalue, :gapped_alignment, :gapped_alignment, :filter_query_sequence, :commit)
      end 


      

      @hits = Hash.new
      @sequences = ActiveSupport::OrderedHash.new
      @new_customized_sequence = CustomizedProteinSequence.new
      protein_sequence = CustomizedProteinSequence.all
      @sequence_group = Hash.new
      protein_sequence.each do |s|
        @sequence_group[s.header] = s.group
      end

      # get list of group and list of organism form protein_sequence
      @group_number_list = Array.new
      @organism_list = Array.new

      # should do one for each request or can do multiple alignment at same time?
      # haven't check for the inapporiate sequence 
      @fasta_seq = fasta_array[0]
      @query = Bio::FastaFormat.new( @fasta_seq )
      query_name = @query.definition
      @sequence = @query.to_seq
      @sequence.auto # Guess the type of sequence. Changes the class of @sequence.
      query_sequence_type = @sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
      program = @sequence.seq.class == Bio::Sequence::AA ? 'blastp' : 'blastn'
      database = query_sequence_type == 'protein' ? 'reductive_dehalogenase_protein' : 'reductive_dehalogenase_gene'
      sequence_class = query_sequence_type == 'protein'? ProteinSequence : NucleotideSequence


      blast_options = set_blast_options(program,params)
      blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
      aa_report = blaster.query(@sequence.seq) # @sequence.seq automatically remove the \n; possibly other wildcard

      @aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f
      @is_exist_chain, @existing_matched_group = get_existing_groups(aa_report,@sequence.seq)
      @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")
      # load the group
      # hash each header to existing group       => reversed_group_hash
      # hash each group for all avaiable headers => group_hash
      group_hash = Hash.new
      reversed_group_hash = Hash.new
      protein_sequence.each do |single_entry|

        if !@group_number_list.include? single_entry.group
          @group_number_list << single_entry.group
        end
        if !@organism_list.include? single_entry.organism
          @organism_list << single_entry.organism
        end


        if single_entry.group.nil?
          next
        else
          reversed_group_hash[single_entry.header] = single_entry.group
          if group_hash[single_entry.group].nil?
            group_array = Array.new
            group_array << single_entry.header
            group_hash[single_entry.group] = group_array
          else

            group_hash[single_entry.group] << single_entry.header

          end
        end

      end # end protein_sequence.each do |single_entry|


      identity_with_90 = get_identity_with_90(aa_report)
      # puts "identity_with_90 => #{identity_with_90.inspect}"
      @identity_groups = Array.new  # identity_group contains the eligible group number      

      if identity_with_90.length > 0
        identity_with_90.each do |definition|
          group_number = reversed_group_hash[definition]
          if !group_number.blank? && !group_number.nil?
            is_belong_to_group = true
            if group_hash[group_number].length == 1
              # if the group just have one member, then if the query is 90% identical to this member
              # then the query belong to the group
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
              if !@identity_groups.include? group_number
                @identity_groups << group_number
              end
            end 

          end 

        end 

      end
      @identity_groups.concat @existing_matched_group
      @identity_groups = @identity_groups.uniq
      @possible_group_number = get_characterized_member_s(@identity_groups)
    end
  end

  # This is for rendering the result at new page
  def result

    if params[:notice].present?
      @error = params[:notice]
    end

    if params[:commit].present?

      if params[:sequence].present?
        params_sequence = params[:sequence].clone
        after_validation = validate_amino_acid_sequnence(params_sequence)
        if after_validation.class == String
          params[:sequence] = after_validation
        elsif after_validation.class == Hash
          error_msg = ""
          after_validation.each do |key, error|
            error_msg += "#{error}\n"
          end
          redirect_to :controller => 'query', :action => 'result', params: params.merge(:notice => error_msg ).permit(:notice) and return
        end

      else
        redirect_to :controller => 'query', :action => 'result', params: params.merge(:notice => "Must provide an amino acid sequence in Fasta format").permit(:notice) and return
      end

      fasta_array = params[:sequence].scan(/>[^>]*/)
      # only allow one sequence at time on server
      if fasta_array.length > 1
        redirect_to :controller => 'query', :action => 'result', params: params.merge(:notice => "Please provide only one sequence.").permit(:notice) and return
      end

      # at this point, the params[:sequence] should be correct fasta format
      fasta_array = params[:sequence].scan(/>[^>]*/) 

      @hits = Hash.new
      @sequences = ActiveSupport::OrderedHash.new
      @new_customized_sequence = CustomizedProteinSequence.new
      protein_sequence = CustomizedProteinSequence.all
      @sequence_group = Hash.new
      protein_sequence.each do |s|
        @sequence_group[s.header] = s.group
      end
      @group_number_list = Array.new
      @organism_list = Array.new
      @fasta_seq = fasta_array[0]
      @query = Bio::FastaFormat.new( @fasta_seq )
      query_name = @query.definition
      @sequence = @query.to_seq
      @sequence.auto # Guess the type of sequence. Changes the class of @sequence.
      query_sequence_type = @sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
      program = @sequence.seq.class == Bio::Sequence::AA ? 'blastp' : 'blastn'
      database = query_sequence_type == 'protein' ? 'reductive_dehalogenase_protein' : 'reductive_dehalogenase_gene'
      sequence_class = query_sequence_type == 'protein'? ProteinSequence : NucleotideSequence
      blast_options = set_blast_options(program,params)
      blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
      aa_report = blaster.query(@sequence.seq)
      @aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f


      @is_exist_chain, @existing_matched_group = get_existing_groups(aa_report,@sequence.seq)
      @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")
      group_hash = Hash.new
      reversed_group_hash = Hash.new
      protein_sequence.each do |single_entry|
        if !@group_number_list.include? single_entry.group
          @group_number_list << single_entry.group
        end
        if !@organism_list.include? single_entry.organism
          @organism_list << single_entry.organism
        end
        if single_entry.group.nil?
          next
        else
          reversed_group_hash[single_entry.header] = single_entry.group
          if group_hash[single_entry.group].nil?
            group_array = Array.new
            group_array << single_entry.header
            group_hash[single_entry.group] = group_array
          else
            group_hash[single_entry.group] << single_entry.header
          end
        end
      end # end protein_sequence.each do |single_entry|


      identity_with_90 = get_identity_with_90(aa_report)
      puts "identity_with_90 => #{identity_with_90.inspect}"
      @identity_groups = Array.new  # identity_group contains the eligible group number
      if identity_with_90.length > 0
        identity_with_90.each do |definition|
          group_number = reversed_group_hash[definition]
          if !group_number.blank? && !group_number.nil?
            is_belong_to_group = true
            if group_hash[group_number].length == 1
              is_belong_to_group = true
            else 
              puts group_hash[group_number].inspect
              group_hash[group_number].each do |s_identity|
                if identity_with_90.include? s_identity
                  next
                else
                  is_belong_to_group = false
                end
              end
            end # end of if group_hash[group_number].length == 1
            if is_belong_to_group == true
              if !@identity_groups.include? group_number
                @identity_groups << group_number
              end
            end # end of is_belong_to_group == true
          end # end of if !group_number.blank? && !group_number.nil?
        end # end of identity_with_90.each do |identity|
      end
      @identity_groups.concat @existing_matched_group
      @identity_groups = @identity_groups.uniq
      @possible_group_number = get_characterized_member_s(@identity_groups.uniq)
      
    else
      redirect_to :controller => 'query', :action => 'search'
    end

  end




  # Create the phylogenies tree
  def phylogenies
    raw_sequence = params[:sequence]
    if raw_sequence == "undefined"
      raw_sequence = params[:form_sequence]
    end

    fasta_array = raw_sequence.scan(/>[^>]*/)
    sequence_def = Bio::FastaFormat.new( fasta_array[0] )
    aa_sequence = sequence_def.to_seq.seq
    
    current_time = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
    fasta_new  = File.open("#{Rails.root}/tmp/tmp_fasta/fasta_#{current_time}.fasta","w")

    # puts "params.inspect => #{params.inspect}"
    all_sequence = extract_sequence_for_tree(params)  # get desired sequence based on user options
    # puts "all_sequence length => #{all_sequence.length}"

    number_of_group = all_sequence.distinct.pluck(:group).length # get number of unique groups

    # obtain group information for colouring and marking the node
    # and add the selected sequence into temporary fasta file
    group_info = Hash.new
    header_pool = Array.new
    all_sequence.each do |s|
      group_info[s.header] = s.group
      if header_pool.include? s.header
        next
      else
        fasta_new << ">#{s.header}\n"
        fasta_new << "#{s.chain}\n"
        header_pool << s.header
      end
    end
    

    # create random name for the sequence if the header field is empty
    # ask user to provide the sequence common name as well as accession number when submiting the sequence
    seq_name_exist = CustomizedProteinSequence.find_by(:header => sequence_def.definition)
      
    highlight_name = nil
    if seq_name_exist.nil?
      # check if the sequence_def.definition is blank
      if !sequence_def.definition.empty?
        highlight_name = sequence_def.definition
      else
        highlight_name = "Submitted_Suquence_1"
      end

      fasta_new << ">#{highlight_name}_Your_Sequence\n"
      fasta_new << "#{aa_sequence}\n"
    else
      highlight_name = "#{sequence_def.definition}_Your_Sequence"
      fasta_new << raw_sequence.gsub(sequence_def.definition, highlight_name) + "\n"
    end
    fasta_new.close()
    
    # the tree is based on AA (amino acid)
    muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    if RUBY_PLATFORM == "x86_64-linux"
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    else
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86darwin64"
    end

    # muscle -maketree -in seqs.afa -out seqs.phy
    if all_sequence.length != 0
      muscle = system( muscle_path,
                        "-in","tmp/tmp_fasta/fasta_#{current_time}.fasta",
                        "-out","tmp/tmp_fasta/#{current_time}.afa",
                        "-maxiters", "1", "-quiet")

      # muscle may not finished, then render
      while muscle.nil?
        next
      end

      muscle = system( muscle_path, 
                      "-maketree", "-in", "tmp/tmp_fasta/#{current_time}.afa",
                      "-out", "tmp/tmp_fasta/#{current_time}.phy")

      while muscle.nil?
        next
      end
      
      phy = File.open("tmp/tmp_fasta/#{current_time}.phy","r")

      tree_data = ""
      phy.each do |line|
        tree_data = tree_data + line.gsub("\n","")
      end
      phy.close()

      render json: { "tree": tree_data, "highlight": highlight_name, 
        "group": group_info, "group_number": number_of_group,
        "num_sequence": all_sequence.length }
    else

      render json: { "num_sequence": all_sequence.length }
    end

  end





  def download_new_fasta 
    # puts "params.inspect => #{params.inspect}"
    filename = params[:file_name]
    send_file filename, :type => "application/fasta", :filename =>  "rdhA_nt_all_customized.fasta"
  end




  private
  def set_search_defaults_for_nt
    params[:gap_cost] ||= '1'
    params[:extend_cost] ||= '1'
    params[:mismatch_penalty] ||= '-2'
    params[:match_reward] ||= '1'
    params[:evalue] ||= '0.000001'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
    params[:new_result_tab] = true if params[:commit].blank?
  end

  def set_blast_defaults_for_aa
    params[:gap_cost] ||= '11'
    params[:extend_cost] ||= '1'
    params[:mismatch_penalty] ||= '-3'
    params[:match_reward] ||= '2'
    params[:evalue] ||= '0.000001'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
    params[:new_result_tab] = true if params[:commit].blank?
  end

end
