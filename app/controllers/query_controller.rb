class QueryController < ApplicationController
	before_action :set_search_defaults

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
      # puts fasta_array.inspect
      @hits = Hash.new
      @sequences = ActiveSupport::OrderedHash.new

      fasta_array.each do |fasta_seq|
      	# for each fasta sequence
      	# 1. create Bio::FastaFormat object
      	# 2. detect the type of sequence (nt or aa)
      	# 3. based on sequence type, choose the program and database
      	# 4. define the blast options
      	# 5. do alignment
        @query = Bio::FastaFormat.new( fasta_seq )
        query_name = @query.definition
        @sequence = @query.to_seq
        @sequence.auto # Guess the type of sequence. Changes the class of @sequence.
        query_sequence_type = @sequence.seq.class == Bio::Sequence::AA ? 'protein' : 'gene'
        program = @sequence.seq.class == Bio::Sequence::AA ? 'blastp' : 'blastn'
        database = query_sequence_type == 'protein' ? 'protein' : 'gene'

        blast_options = { 'e' => params[:evalue].to_f, 'G' => params[:gap_cost].to_i,
                          'E' => params[:extend_cost].to_i, 'q' => params[:mismatch_penalty].to_i, 'r' => params[:match_reward].to_i,
                          'U' => (params[:lower_case_filtering].present? ? 'T' : 'F'), 
                          'F' => (params[:filter_query_sequence].present? ? 'T' : 'F'),
                          'g' => (params[:gapped_alignment].present? ? 'T' : 'F') }
        blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")

        blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)
        puts blaster.inspect
        report = blaster.query(@sequence.seq)

        hit_array = Hash.new

        report.each do |hit|
          if hit.target_def =~ /(\d+)/
            hit_array[$1.to_i] = hit
            @hits[[$1.to_i, query_name]] = hit
          end
        end
        # resultlist = sequence_class.find(hit_array.keys)
        # resultlist.sort! { |a, b| hit_array[b.id].bit_score <=> hit_array[a.id].bit_score }

        # if params[:filters].present?
        #   resultlist = 
        #     resultlist.select { |s| (!s.sequenceable.respond_to?('include_in_blast_search?') || 
        #                             s.sequenceable.include_in_blast_search?(params[:filters])) }
        # end
        # @sequences[query_name] = resultlist
      end
    end    
  end

  private

  def set_search_defaults
    params[:gap_cost] ||= '-1'
    params[:extend_cost] ||= '-1'
    params[:mismatch_penalty] ||= '-3'
    params[:match_reward] ||= '1'
    params[:gapped_alignment] = true if params[:commit].blank?
    params[:filter_query_sequence] = true if params[:commit].blank?
  end

end
