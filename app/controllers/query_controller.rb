class QueryController < ApplicationController
  # include concerns
  include QueryLogic

	before_action :set_blast_defaults_for_aa

  def search
    @available_database = ["eductive_dehalogenase (revised)","eductive_dehalogenase (non-revised)"]
    @available_organism = ["fake fake fake fake organism_1_","fake organism_2"]

    # return {... "Database"=>"eductive_dehalogenase (customized)" ...}
    # save user query no matter what but without any user information
    # only ask user information if the sequence is good
    begin
      user_input = Query.new
      user_input.sequence = params[:sequence].gsub("\n","|").gsub(">","")
      user_input.save!
    rescue
      user_input.sequence = "NULL"
      user_input.save!
    end

    
    # params.inspect
    params[:filters] ||= {}

    if params[:commit].present?
      if params[:sequence].blank?
        redirect_to(search_path, notice: "Must provide valid sequence") and return
      end

      if params[:sequence].strip !~ /^>/
        params[:sequence] = ">Submitted Sequence 1\n#{params[:sequence]}"
      end

      fasta_array = params[:sequence].scan(/>[^>]*/)
      
      @hits = Hash.new
      @sequences = ActiveSupport::OrderedHash.new
      @new_customized_sequence = CustomizedProteinSequence.new
      protein_sequence = ProteinSequence.all
      @sequence_group = Hash.new
      protein_sequence.each do |s|
        @sequence_group[s.header] = s.group
      end

      # should do one for each request or can do multiple alignment at same time?
      # haven't check for the inapporiate sequence 
      fasta_array.each do |fasta_seq|

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


        # add group information




        # if there is sequence in db has evalue 0, indicates the sequence is already in database
        @is_match = false
        aa_report.each do |hit|
          if hit.evalue == 0
            @is_match = true
          end
        end

        @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")



        # for first sequence in aa_fasta
        # note: 0.9 for 11,1 is too high; 0.8 is good
        # same for tblastn, 0.8 is good
        if @aa_similarity > 0.80
          
          # load the group
          # hash each header to existing group       => reversed_group_hash
          # hash each group for all avaiable headers => group_hash
          group_hash = Hash.new
          reversed_group_hash = Hash.new
          protein_sequence.each do |single_entry|
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
          identity_with_90 = Array.new 
          aa_report.each do |hit|
            match_identity = (hit.identity * 100) / hit.query_len
            if match_identity >= 90
              identity_with_90 << hit.target_def
            end

          end # end of aa_report.each do |hit|

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
              if !group_number.blank? && !group_number.nil?
                is_belong_to_group = true

                if group_hash[group_number].length == 1
                  is_belong_to_group = true
                else 
                  # if one of them is not included, then the query doesn't belong to the group
                  group_hash[group_number].each do |s_identity|
                    if identity_with_90.include? reversed_group_hashs_group[s_identity]
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

        # no similarity at 80%, just show the tree feature

        break # only parse one fasta file
      end # end of fasta_array.each
    end   
  end


  def result


  end


  def phylogenies
    # <!-- Step -->
    # <!-- make sure the base alignment is exist (sys) -->
    # <!-- add new sequence to fasta file -->
    # <!-- do MUSCLE alignment -->
    # <!-- iqtree generate the graph -->
    # <!-- use biojs load the graph -->
    raw_sequence = params[:sequence]
    fasta_array = raw_sequence.scan(/>[^>]*/)
    sequence_def = Bio::FastaFormat.new( fasta_array[0] )

    current_time = Time.now.strftime("%Y/%m/%d %H:%M:%S").gsub("/","_").gsub(" ","_").gsub(":","_")
    fasta_base = File.open("#{Rails.root}/data/rdhA_all_aa_17-June-2019.fasta","r")
    fasta_new  = File.open("#{Rails.root}/tmp/tmp_fasta/fasta_#{current_time}.fasta","w")


    # check if the sequence id have already taken place
    # tree can't accept the duplicate name

    # render group information 
    all_sequence = CustomizedProteinSequence.all
    number_of_group = all_sequence.distinct.pluck(:group).length - 1 # remove null
    group_info = Hash.new
    all_sequence.each do |s|
      group_info[s.header] = s.group
    end

    seq_name_exist = CustomizedProteinSequence.find_by(:header => sequence_def.definition)
    highlight_name = sequence_def.definition
    if seq_name_exist.nil?
      fasta_new << raw_sequence + "\n"
    else
      highlight_name = "#{sequence_def.definition}_2"
      fasta_new << raw_sequence.gsub(sequence_def.definition, highlight_name) + "\n"
    end

    fasta_base.each do |line|
      fasta_new << line
    end

    fasta_base.close()
    fasta_new.close()


    # the tree is based on AA (amino acid)
    # muscle -in seqs.fa -out seqs.afa -maxiters 1 -diags -sv -distance1 kbit20_3
    # muscle can't do multi-core feature
    # cmd = "vendor/MUSCLE/muscle3.8.31_i86darwin64 
    # -in tmp/tmp_fasta/fasta_#{current_time}.fasta 
    # -out tmp/tmp_fasta/#{current_time}.afa 
    # -tree1 tmp/tmp_fasta/#{current_time}.phy 
    # -maxiters 1 
    # -diags -sv 
    # -distance1 kbit20_3" 
    # default path is linux path
    muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    if RUBY_PLATFORM == "x86_64-linux"
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
    else
      muscle_path = "vendor/MUSCLE/muscle3.8.31_i86darwin64"
    end

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
    # phy = File.open("tmp/tmp_fasta/rdha_aligned-minus-first-3.afa.treefile","r")
    

    tree_data = ""
    phy.each do |line|
      tree_data = tree_data + line.gsub("\n","")
    end
    phy.close()

    render json: { "tree": tree_data, "highlight": highlight_name, "group": group_info, "group_number": number_of_group }

    # puts "START IQTREE"
    # iqtree = system( "vendor/iqtree-1.6.11-MacOSX/bin/iqtree", 
    #                   "-s","tmp/tmp_fasta/#{current_time}.afa",
    #                   "-nt", "AUTO",
    #                   "-m", "Dayhoff",
    #                   "-bb", "1000",
    #                   "-quiet",
    #                   "-st","AA")
    # puts iqtree
    # puts "DONE IQTREE"
  end

  def submit_sequence
    # puts "inspectparams"
    # puts params[:name]
    # puts params[:institution]
    # puts params[:email]
    # puts params[:publications]
    # puts params[:sequence]

    #  params[:group] may have the array of group to put on
    # - if @append_seq_to_relative_rd_og == true
    #   / send what group it belongs to, either assign to a group or create new group
    #   = render partial: "submit_sequence", group: @final_identity_groups
    # - elsif @append_seq_to_relative_rd_og_without_group == true
    #   / send no group it belongs to
    #   = render partial: "submit_sequence", group: @final_identity_groups
    # - elsif @append_seq_to_csv == true
    #   = render partial: "submit_sequence" 

    

    fasta_array = params[:sequence].scan(/>[^>]*/)

    query_name = nil
    sequence = nil
    if fasta_array.length > 1
      @query = Bio::FastaFormat.new( fasta_array[0] )
      query_name = @query.definition
      sequence = @query.to_seq
    end
    # puts params.inspect

    begin
      # organism should be similar, otherwise it won't get to this step
      new_sequence_info = SequenceInfo.new
      new_sequence_info.organism = params[:organism] || nil
      new_sequence_info.reference = params[:publications] || nil
      new_sequence_info.type = "Enzyme"


      new_customized_protein_sequences = CustomizedProteinSequence.new
      new_customized_protein_sequences.header = query_name
      new_customized_protein_sequences.chain  = sequence
      # new_customized_protein_sequences.group  = "novel" or "some group"
      new_customized_protein_sequences.reference = params[:publications] || nil
      new_customized_protein_sequences.organism  = params[:organism] || nil
      

      # also send a email to our lab to indicate the new sequence has been inserted
      # make sure no malicious traffic and garbage input
      # new_sequence_info.save!
      # new_customized_protein_sequences.save!
      # if recaptcha is selected, it will encrypt all input invalues
      # verify_recaptcha() will verify the sent encrypt value to actual input value
      if verify_recaptcha(params) 
        new_sequence_info.save!
        new_customized_protein_sequences.save!
        # create the new blast database
        # make sure that user won't do nucletide sequence search
        sequence = CustomizedProteinSequence.all
        now = Time.now.strftime("%Y_%m_%d_%H_%M_%S")
        filename = "tmp/database_fasta_db/rdhA_aa_all_customized_#{now}.fasta"
        aa_fasta_file = File.open(filename,"w")

        sequence.each{ |x|
          aa_fasta_file.write(">")
          aa_fasta_file.write(s.header)
          aa_fasta_file.write("\n")
          aa_fasta_file.write(s.chain)
          aa_fasta_file.write("\n")
        }

        aa_fasta_file.close

        blast_database = system( "makeblastdb", 
                      "-in", filename,
                      "-dbtype", "'prot'", 
                      "-out", "#{Rails.root}/index/blast/reductive_dehalogenase_protein" )

        # File.delete(filename) if File.exist?(filename)
        # ActionMailer::Base.mail(from: params[:email], to: "danis.cao@hotmail.com", subject: query_name, body: params).deliver
      else
        # create a new form to submit sequence
        render json: {"message": "Your Sequence has been sent to 
        Elizabeth Edwards Lab. Thank you for your contribution"}
      end

      render json: {"message": "Your Sequence has been sent to 
        Elizabeth Edwards Lab. Thank you for your contribution"} 
    rescue Exception => e 
      render json: {"message_err": e.message }

    end

    
  end


  private


  # the defaults of match/mismatch gap costs are based on ncbi blast web
  # https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome
  # NCBI use default linear for gap cost; ask them what linear means
  def set_search_defaults_for_nt
    params[:gap_cost] ||= '1'
    params[:extend_cost] ||= '1'
    params[:mismatch_penalty] ||= '-2'
    params[:match_reward] ||= '1'
    params[:evalue] ||= '0.000001'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
  end

  def set_blast_defaults_for_aa
    params[:gap_cost] ||= '11'
    params[:extend_cost] ||= '1'
    params[:mismatch_penalty] ||= '-3'
    params[:match_reward] ||= '2'
    params[:evalue] ||= '0.000001'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
  end

end
