module QueryLogic
	extend ActiveSupport::Concern



	def set_blast_options(program, params)
		
		if program == "blastp"
		  blast_options = { 'e' => params[:evalue].to_f, 
		  								'G' => params[:gap_cost].to_i,
		                  'E' => params[:extend_cost].to_i,
		                  'U' => (params[:lower_case_filtering].present? ? 'T' : 'F'), 
		                  'F' => (params[:filter_query_sequence].present? ? 'T' : 'F'),
		                  'g' => (params[:gapped_alignment].present? ? 'T' : 'F') }
		  
		  blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
		  
		  return blast_options

		elsif program == "blastn"
		  blast_options = { 'e' => params[:evalue].to_f, 
		  									'G' => params[:gap_cost].to_i,
		                  'E' => params[:extend_cost].to_i, 
		                  'q' => params[:mismatch_penalty].to_i, 
		                  'r' => params[:match_reward].to_i,
		                  'U' => (params[:lower_case_filtering].present? ? 'T' : 'F'), 
		                  'F' => (params[:filter_query_sequence].present? ? 'T' : 'F'),
		                  'g' => (params[:gapped_alignment].present? ? 'T' : 'F') }
		  
		  blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
		  
		  return blast_options

		end

	end

	def run_tblastn(seq,database,blast_options=nil)
		# run tblastn program
		# Params: Bio:Blast:Report
		# Return: float
		# +command+:: 
		# +outhandler+:: +Proc+ 
		# +errhandler+:: +Proc+

		report = nil
		if blast_options.nil?
			# set default evalue
			blast_options = { 'e' => 0.10 }
			blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
			blaster = Bio::Blast.local('tblastn', "#{Rails.root}/index/blast/#{database}",blast_options)
			report = blaster.query(seq)

		else

			blast_options = blast_options.collect { |key, value| value.present? ? "-#{key} #{value}" : nil }.compact.join(" ")
			blaster = Bio::Blast.local('tblastn', "#{Rails.root}/index/blast/#{database}",blast_options)
			report = blaster.query(seq)

		end

		return report
	end


	def generate_hit_array(report,query_name,query_sequence_type)
		
		sequences = Array.new
		report.each do |hit|
			sequences << hit
		end

		return sequences
	end

	def validate_ncbi_accession_number(accession_number)
		url = "https://www.ncbi.nlm.nih.gov/protein/#{accession_number}"
		request = URI.parse(url)
	end


	def describt_hit(hit)
		# print all hit information
		# Params: Bio:Blast:Report:hit
		# +command+:: 
		# +outhandler+:: +Proc+ 
		# +errhandler+:: +Proc+
		puts hit.evalue           # E-value
		# puts hit.sw               # Smith-Waterman score (*)
		puts hit.identity         # % identity use this to compare the sequence 
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

  # blast+ ncbi program
  # blastdb_aliastool
  # blastdbcheck
  # blastdbcmd
  # blast_formatter
  # blastn
  # blastp
  # blastx
  # convert2blastmask
  # deltablast
  # dustmasker
  # legacy_blast.pl
  # makeblastdb
  # makembindex
  # makeprofiledb
  # psiblast
  # rpsblast
  # rpstblastn
  # segmasker
  # tblastn
  # tblastx
  # update_blastdb.pl
  # windowmasker
end