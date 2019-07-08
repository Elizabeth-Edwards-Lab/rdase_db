class QueryController < ApplicationController
  # include concerns
  include QueryLogic

	before_action :set_blast_defaults_for_aa

  def search
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

      # should do one for each request or can do multiple alignment at same time?
      fasta_array.each do |fasta_seq|

        @query = Bio::FastaFormat.new( fasta_seq )
        query_name = @query.definition
        @sequence = @query.to_seq
        @sequence.auto # Guess the type of sequence. Changes the class of @sequence.
        query_sequence_type = @sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
        program = @sequence.seq.class == Bio::Sequence::AA ? 'blastp' : 'blastn'
        database = query_sequence_type == 'protein' ? 'reductive_dehalogenase_protein' : 'reductive_dehalogenase_gene'
        
        blast_options = set_blast_options(program,params)
        blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
        aa_report = blaster.query(@sequence.seq)

        @aa_similarity =  aa_report.hits().length.to_f / aa_report.db_num().to_f



        # if there is sequence in db has evalue 0, indicates the sequence is already in database
        @is_match = false
        aa_report.each do |hit|
          if hit.evalue == 0
            @is_match = true
          end
        end


        @aa_sequence_result = generate_hit_array(aa_report,query_name,"protein")
        @aa_sequence_result = Kaminari.paginate_array(@aa_sequence_result,total_count: @aa_sequence_result.count).page(params[:page]).per(5)

        ## search aa level > 90%
        ## if >90%, do nt level
        

        # for first sequence in aa_fasta
        # note: 0.9 for 11,1 is too high; 0.8 is good
        # same for tblastn, 0.8 is good
        if @aa_similarity > 0.80
          
          # if in the ortholog_group (HOW?), confirm with blast gene
          #    if blast gene is > 90% from that group
          #       Step3
          #    else
          #       Step3 with condition (dont add to database)
          # else
          #    Step2
          # end
          # 
          nt_report = run_tblastn(@sequence.seq,"reductive_dehalogenase_gene")
          @nt_similarity = nt_report.hits().length.to_f / nt_report.db_num().to_f
          if @nt_similarity > 0.80

            # append_seq_to_rd_og(@sequence.seq, @sequence.definition)
            # append_seq_to_rd_og_info(input_info)

          else

            # append_seq_to_relative_rd_og(@sequence.seq, @sequence.definition)

          end


          


        else

        end # end of @aa_similarity > 0.80

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

    # base fasta file
    fasta_base = File.open("#{Rails.root}/data/rdhA_all_aa_17-June-2019.fasta","r")
    # new fasta file 
    current_time = Time.now.strftime("%Y/%m/%d %H:%M:%S").gsub("/","_").gsub(" ","_").gsub(":","_")
    fasta_new  = File.open("#{Rails.root}/tmp/tmp_fasta/fasta_#{current_time}.fasta","w")
    fasta_new << raw_sequence + "\n"
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
    muscle = system( "vendor/MUSCLE/muscle3.8.31_i86darwin64",
                      "-in","tmp/tmp_fasta/fasta_#{current_time}.fasta",
                      "-out","tmp/tmp_fasta/#{current_time}.afa",
                      "-tree1", "tmp/tmp_fasta/#{current_time}.phy",
                      "-maxiters", "1",
                      "-diags","-sv",
                      "-distance1","kbit20_3","-quiet")


    puts muscle

    phy = File.open("tmp/tmp_fasta/#{current_time}.phy","r")
    tree_data = ""
    phy.each do |line|
      tree_data = tree_data + line.gsub("\n","")
    end
    phy.close()


    render json: { "tree": tree_data }

    # render #{Rails.root}/tmp/tmp_fasta/#{current_time}.phy


    # do iqtree
    # since MUSCLE come with approximate tree development, don't do iqtree for now
    # -s path/to/this/file/rdha_aligned.afa -nt AUTO -m Dayhoff -bb 1000 -redo
    # render the .treefile => #{current_time}.afa.treefile
    iqtree = system ( "vendor/iqtree-1.6.11-MacOSX/bin/iqtree", 
                      "-s","tmp/tmp_fasta/#{current_time}.afa",
                      "-nt", "AUTO",
                      "-m", "Dayhoff",
                      "-bb", "1000",
                      "-quiet",
                      "-st","AA")
    phy = File.open("tmp/tmp_fasta/#{current_time}.afa.treefile","r")
    tree_data = ""
    phy.each do |line|
      tree_data = tree_data + line.gsub("\n","")
    end
    phy.close()


    render json: { "tree": tree_data }
    puts iqtree
    # if muscle == true





  end

  def submit_sequence
    # puts "inspectparams"
    # puts params[:name]
    # puts params[:institution]
    # puts params[:email]
    # puts params[:publications]
    # puts params[:sequence]
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
    params[:evalue] ||= '0.01'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
  end

end
