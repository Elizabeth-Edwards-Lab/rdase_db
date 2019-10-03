class QueryController < ApplicationController
  # include concerns
  include QueryLogic
  include QueryValidator # concerns is for reducing logic in controller
  helper QueryHelper # helper is for reducing logic in view
  # for reducing logic in ActiveRecord, do it in model file

	before_action :set_blast_defaults_for_aa

  def search

    puts "params.inspect => #{params.inspect}"
    if params[:notice].present?
      @error = params[:notice]
    end

    # params.inspect
    params[:filters] ||= {}

    if params[:commit].present?
      # do parameter validation
      # sequence can't be too long
      # etc.
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

      if params[:new_result_tab] == "1"
        
        redirect_to :controller => 'query', :action => 'result', params: params.merge(:sequence => params[:sequence],
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
      fasta_array.each do |fasta_seq|
        @fasta_seq = fasta_seq
        @query = Bio::FastaFormat.new( fasta_seq )
        query_name = @query.definition
        @sequence = @query.to_seq
        @sequence.auto # Guess the type of sequence. Changes the class of @sequence.
        query_sequence_type = @sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
        program = @sequence.seq.class == Bio::Sequence::AA ? 'blastp' : 'blastn'
        database = query_sequence_type == 'protein' ? 'reductive_dehalogenase_protein' : 'reductive_dehalogenase_gene'
        sequence_class = query_sequence_type == 'protein'? ProteinSequence : NucleotideSequence

        # Save the query for "each" sequence
        begin
          user_input = Query.new
          user_input.sequence = @sequence.seq
          user_input.save!
        rescue 
          user_input = Query.new
          user_input.save!
        end


        blast_options = set_blast_options(program,params)
        blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
        aa_report = blaster.query(@sequence.seq) # @sequence.seq automatically remove the \n; possibly other wildcard

        @aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f

        # if there is sequence in db has evalue 0, indicates the sequence is already in database
        @is_exist_chain = false
        @existing_matched_group = nil
        aa_report.each do |hit|
          if hit.evalue == 0
            existing_matched_group_exist = CustomizedProteinSequence.find_by(:chain => @sequence.seq)
            if !existing_matched_group_exist.nil?
              @is_exist_chain = true
              @existing_matched_group = existing_matched_group_exist.group
            end
          end
        end


        # puts "@existing_matched_group => #{@existing_matched_group}"
        # puts "@is_exist_chain => #{@is_exist_chain}"

        @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")

        # for first sequence in aa_fasta
        # note: 0.9 for 11,1 is too high; 0.8 is good
        # same for tblastn, 0.8 is good
        if @aa_similarity > 0.0
          
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

          # identify the group of orth
          # If your sequence shares greater than or equal to 90% pairwise ID are the amino acid level to a current RdhA database sequence
          # query_sequence have low e-value with 90% of amino acid sequence in database?
          # or query_sequence has 90% similarity (identity) with all sequence in database?

          # identity_with_90 contains all the sequence header with 90% identity
          # if the match identity is greater than 90%, add to identity_with_90 array
          # in order to find the RD_OG group, find all match_identity first
          identity_with_90 = Array.new 
          aa_report.each do |hit|
            match_identity = (hit.identity * 100) / hit.query_len
            # puts "#{hit.target_def} => #{match_identity}"
            if match_identity >= 90
              identity_with_90 << hit.target_def
            end

          end # end of aa_report.each do |hit|
          # puts "identity_with_90 definition => #{identity_with_90.inspect}"


          identity_groups = Array.new  # identity_group contains the eligiable group number
          
          # if there is no sequence that is identity with 90%
          # conclude no group matched and but greater 80% similarity with entire database in AA level
          # just run the tree feature
          if identity_with_90.length > 0
            # for each definition, get the its group_number
            # if it is just one sequence group, then the query is belong to that group
            # add to identity_groups
            # else if the group has more than one sequence, check if each one share 90% of identity
            identity_with_90.each do |definition|
              group_number = reversed_group_hash[definition]
              # puts group_number
              if !group_number.blank? && !group_number.nil?
                is_belong_to_group = true
                # puts "group_hash[group_number] => #{group_hash[group_number]}"
                # puts "group_hash[group_number].length => #{group_hash[group_number].length}"
                if group_hash[group_number].length == 1
                  # if the group just have one member, then if the query is 90% identical to this member
                  # then the query belong to the group
                  is_belong_to_group = true

                else 
                  # if one of them is not included, then the query doesn't belong to the group
                  # retrieve all the member in this group
                  # check if all the member is in identity_with_90
                  # puts "group_hash[group_number] => #{group_number[group_number]}"
                  group_hash[group_number].each do |s_identity|
                    
                    # puts "reversed_group_hash[s_identity] => #{reversed_group_hash[s_identity]}"
                    if identity_with_90.include? s_identity
                      next
                    else
                      is_belong_to_group = false
                    end
                  end
                end # end of if group_hash[group_number].length == 1

                if is_belong_to_group == true
                  if !identity_groups.include? group_number
                    identity_groups << group_number
                  end
                end # end of is_belong_to_group == true
              end # end of if !group_number.blank? && !group_number.nil?
              # should create a new group based on average aa sequence similiarity larger than 90%
              # yes, this logic is at later processing

              # if remove the step check if all other sequences (at same group) also share match_identity with greater than 90.
              # identity_groups << reversed_group_hash[definition]
            end # end of identity_with_90.each do |identity|

              

            # puts "identity_groups => #{identity_groups}"

            @final_identity_groups = Array.new # this is final check for the similarity
            @append_seq_to_relative_rd_og = false
            @append_seq_to_relative_rd_og_without_group = false
            @append_seq_to_new_rd_og = false

            # if the sequence belong to one group, double check with DNA level
            # to check DNA level, run tblastn (convert AA to NT and against NT database)
            # and only check for the sequence within group
            # (how to construct new nt blast database?) you can't simply translate AA to NT
            if identity_groups.length > 0

              dna_level_hit_90 = Array.new
              nt_report = run_tblastn(@sequence.seq,"reductive_dehalogenase_gene")
              # @nt_similarity = nt_report.hits().length.to_f / nt_report.db_num().to_f

              nt_report.each do |hit|
                match_identity = (hit.identity * 100) / hit.query_len
                # puts "#{hit.target_def} => #{match_identity}"
                if match_identity >= 90
                  dna_level_hit_90 << hit.target_def  
                end
              end

              # if the dna_level_hit_90 has more than one sequence, check what they are 
              # dna_level_hit_90 contains matching definition
              # if pass final_check_pass, then add to @final_identity_groups for showing to user
              # group_hash => hash each group for all avaiable headers
              # identity_groups contains all the matched group number at AA level
              if dna_level_hit_90.length > 0
                # if has some more than 90 check each group
                # for each identity_groups
                identity_groups.each do |group_number|
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
                    @final_identity_groups << group_number
                  end
                end # end of identity_groups.each do |group_number|
              end # end of dna_level_hit_90.length > 1


              if @final_identity_groups.length > 0
                # add to database 
                @append_seq_to_relative_rd_og = true
              else
                @append_seq_to_relative_rd_og_without_group = true

              end

            else # if identity_groups.length == 0 (share more than 80% of all aa sequence; but
                 #                                  doesn't belong to any groups)
              @append_seq_to_csv = true # just save to database, do nothing


            end

          else # identity_with_90.length == 0 # doesn't belong to any group
               
            # save to csv/xlsx but not database
            @append_seq_to_csv = true

          end # end of identity_with_90.length > 0

        end # end of @aa_similarity > 0.80

        break # only parse one fasta file
      end # end of fasta_array.each
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
      fasta_array.each do |fasta_seq|
        @fasta_seq = fasta_seq
        @query = Bio::FastaFormat.new( fasta_seq )
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
        @is_exist_chain = false
        @existing_matched_group = nil
        aa_report.each do |hit|
          if hit.evalue == 0
            existing_matched_group_exist = CustomizedProteinSequence.find_by(:chain => @sequence.seq)
            if !existing_matched_group_exist.nil?
              @is_exist_chain = true
              @existing_matched_group = existing_matched_group_exist.group
            end
          end
        end
        @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")
        if @aa_similarity > 0.0
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
          identity_with_90 = Array.new 
          aa_report.each do |hit|
            match_identity = (hit.identity * 100) / hit.query_len
            if match_identity >= 90
              identity_with_90 << hit.target_def
            end
          end # end of aa_report.each do |hit|
          identity_groups = Array.new  # identity_group contains the eligiable group number
          if identity_with_90.length > 0
            identity_with_90.each do |definition|
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
                end # end of if group_hash[group_number].length == 1
                if is_belong_to_group == true
                  if !identity_groups.include? group_number
                    identity_groups << group_number
                  end
                end # end of is_belong_to_group == true
              end # end of if !group_number.blank? && !group_number.nil?
            end # end of identity_with_90.each do |identity|
            @final_identity_groups = Array.new # this is final check for the similarity
            @append_seq_to_relative_rd_og = false
            @append_seq_to_relative_rd_og_without_group = false
            @append_seq_to_new_rd_og = false
            if identity_groups.length > 0
              dna_level_hit_90 = Array.new
              nt_report = run_tblastn(@sequence.seq,"reductive_dehalogenase_gene")
              nt_report.each do |hit|
                match_identity = (hit.identity * 100) / hit.query_len
                if match_identity >= 90
                  dna_level_hit_90 << hit.target_def  
                end
              end
              if dna_level_hit_90.length > 0
                identity_groups.each do |group_number|
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
                    @final_identity_groups << group_number
                  end
                end # end of identity_groups.each do |group_number|
              end # end of dna_level_hit_90.length > 1
              if @final_identity_groups.length > 0
                @append_seq_to_relative_rd_og = true
              else
                @append_seq_to_relative_rd_og_without_group = true
              end
            else # if identity_groups.length == 0 (share more than 80% of all aa sequence; but
              @append_seq_to_csv = true # just save to database, do nothing
            end
          else # identity_with_90.length == 0 # doesn't belong to any group
            @append_seq_to_csv = true
          end # end of identity_with_90.length > 0

        end # end of @aa_similarity > 0.80

        break # only parse one fasta file
      end # end of fasta_array.each
      
    else # if params[:commit].present? is false
      redirect_to :controller => 'query', :action => 'search'
    end

  end

  # Create the phylogenies tree
  def phylogenies
    puts "params => #{params.inspect}"
    # try to get params[:sequence] first. If nil, means new page is rendered
    raw_sequence = params[:sequence]
    if raw_sequence == "undefined"
      raw_sequence = params[:form_sequence]
    end

    fasta_array = raw_sequence.scan(/>[^>]*/)
    sequence_def = Bio::FastaFormat.new( fasta_array[0] )
    aa_sequence = sequence_def.to_seq.seq
    
    current_time = Time.now.strftime("%Y/%m/%d %H:%M:%S_%L").gsub("/","_").gsub(" ","_").gsub(":","_")
    fasta_new  = File.open("#{Rails.root}/tmp/tmp_fasta/fasta_#{current_time}.fasta","w")

    all_sequence = nil
    # all_sequence = CustomizedProteinSequence.all
    # number_of_group = all_sequence.distinct.pluck(:group).length - 1 # remove null
    
    if params[:group] != "" and params[:organism] == ""
      all_sequence = CustomizedProteinSequence.where(:group => params[:group])
    elsif params[:group] == "" and params[:organism] != ""
      all_sequence = CustomizedProteinSequence.where(:organism => params[:organism])
    elsif params[:group] != "" and params[:organism] != ""
      all_sequence = CustomizedProteinSequence.where(:group => params[:group], :organism => params[:organism])
    else
      all_sequence = CustomizedProteinSequence.all
    end

    number_of_group = all_sequence.distinct.pluck(:group).length

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
    puts "highlight_name => #{highlight_name}"
    puts "num of selected sequence => #{all_sequence.length}"
    # the tree is based on AA (amino acid)
    muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    if RUBY_PLATFORM == "x86_64-linux"
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    else
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86darwin64"
    end

    if all_sequence.length != 0
      muscle = system( muscle_path,
                        "-in","tmp/tmp_fasta/fasta_#{current_time}.fasta",
                        "-out","tmp/tmp_fasta/#{current_time}.afa",
                        "-tree1", "tmp/tmp_fasta/#{current_time}.phy",
                        "-maxiters", "1",
                        "-diags","-sv",
                        "-distance1","kbit20_3","-quiet")

      # muscle may not finished, then render
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


  # implement the decision tree
  def submit_sequence
    puts "params.inspect => #{params.inspect}"

    raw_sequence = params[:sequence]
    if raw_sequence == "undefined"
      raw_sequence = params[:form_sequence]
    end
    fasta_array = raw_sequence.scan(/>[^>]*/)

    query_name = nil
    sequence = nil
    if fasta_array.length > 1
      @query = Bio::FastaFormat.new( fasta_array[0] )
      query_name = @query.definition
      sequence = @query.to_seq
    end

    begin
      # organism should be similar, otherwise it won't get to this step
      new_sequence_info = SequenceInfo.new
      new_sequence_info.organism = params[:organism] || nil
      new_sequence_info.reference = params[:publications] || nil
      new_sequence_info.type = "Enzyme"
      new_customized_protein_sequences = CustomizedProteinSequence.new
      new_customized_protein_sequences.header = query_name
      new_customized_protein_sequences.chain  = sequence
      new_customized_protein_sequences.key_group = "NCBI Accession"
      new_customized_protein_sequences.key = params[:ncbi_accession_number]
      new_customized_protein_sequences.reference = params[:publications] || nil
      new_customized_protein_sequences.organism  = params[:organism] || nil
    
    rescue Exception => e 
      render json: {"message_err": e.message }

    end
    
  end

    # def index
    #   @posts = Post.all
    #   respond_to do |format|
    #     format.html  # index.html.erb => will render the index.html.erb as default
    #     format.json  { render :json => @posts } => will render index.html.json as default; it will render other if specified
    #   end
    # end


  def download_new_fasta 
    puts "params.inspect => #{params.inspect}"
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
