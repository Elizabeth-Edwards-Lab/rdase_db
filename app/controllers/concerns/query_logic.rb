module QueryLogic
	extend ActiveSupport::Concern



	def set_blast_options(program, params)
		
		if program == "blastp"
		  blast_options = { 'e' => params[:evalue].to_f, 'G' => params[:gap_cost].to_i,
		                  'E' => params[:extend_cost].to_i,
		                  'U' => (params[:lower_case_filtering].present? ? 'T' : 'F'), 
		                  'F' => (params[:filter_query_sequence].present? ? 'T' : 'F'),
		                  'g' => (params[:gapped_alignment].present? ? 'T' : 'F') }
		  
		  blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
		  
		  return blast_options

		elsif program == "blastn"
		  blast_options = { 'e' => params[:evalue].to_f, 'G' => params[:gap_cost].to_i,
		                  'E' => params[:extend_cost].to_i, 'q' => params[:mismatch_penalty].to_i, 'r' => params[:match_reward].to_i,
		                  'U' => (params[:lower_case_filtering].present? ? 'T' : 'F'), 
		                  'F' => (params[:filter_query_sequence].present? ? 'T' : 'F'),
		                  'g' => (params[:gapped_alignment].present? ? 'T' : 'F') }
		  
		  blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
		  
		  return blast_options

		end

	end

	def describt_hit(hit)
		puts hit.evalue           # E-value
		# puts hit.sw               # Smith-Waterman score (*)
		puts hit.identity         # % identity
		puts hit.overlap          # length of overlapping region
		puts hit.query_id         # identifier of query sequence
		puts hit.query_def        # definition(comment line) of query sequence
		puts hit.query_len        # length of query sequence
		puts hit.query_seq        # sequence of homologous region
		puts hit.target_id        # identifier of hit sequence
		puts hit.target_def       # definition(comment line) of hit sequence
		puts hit.target_len       # length of hit sequence
		puts hit.target_seq       # hit of homologous region of hit sequence
		puts hit.query_start      # start position of homologous
		                              # region in query sequence
		puts hit.query_end        # end position of homologous region
		                              # in query sequence
		puts hit.target_start     # start position of homologous region
		                              # in hit(target) sequence
		puts hit.target_end       # end position of homologous region
		                              # in hit(target) sequence
		puts hit.lap_at           # array of above four numbers
		puts "================"
	end

	def similartiy_percent(identity,query_len)
		percent = identity.to_f / query_len.to_f * 100.0
		return percent
	end



	
	def other_blast_infomation()
		    # # *Arguments*:
		    # # * _program_ (required): 'blastn', 'blastp', 'blastx', 'tblastn' or 'tblastx'
		    # # * _db_ (required): name of the local database
		    # # * _options_: blastall options \
		    # # (see http://www.genome.jp/dbget-bin/show_man?blast2)
		    # # * _blastall_: full path to blastall program (e.g. "/opt/bin/blastall"; DEFAULT: "blastall")
		    # # *Returns*:: Bio::Blast factory object
		    # def self.local(program, db, options = '', blastall = nil)
		    #   f = self.new(program, db, options, 'local')
		    #   if blastall then
		    #     f.blastall = blastall
		    #   end
		    #   f
		    # end
				#blaster = Bio::Blast.local( program, "#{Rails.root}/index/blast/#{database}", blast_options)

	end

	# Other unused code
	      # puts "@hits ================"
        # @hits.each do |hit|
        #   puts hit
        #   puts "---"
        # end


        # resultlist = sequence_class.find(hit_array.keys)
        # resultlist.sort! { |a, b| hit_array[b.id].bit_score <=> hit_array[a.id].bit_score }

        # if params[:filters].present?
        #   resultlist = 
        #     resultlist.select { |s| (!s.sequenceable.respond_to?('include_in_blast_search?') || 
        #                             s.sequenceable.include_in_blast_search?(params[:filters])) }
        # end
        # @sequences[query_name] = resultlist

end