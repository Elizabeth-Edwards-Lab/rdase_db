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


	# package the filtered result into csv file
	# Params: CustomizedProteinSequence activerecord
	# For ProteinController#download_filtered_result
	# +command+:: 
	# +outhandler+:: +Proc+ 
	# +errhandler+:: +Proc+
	def package_csv_for_filtered_result(protein)
		
		now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
    filename = "tmp/filtered_result/filtered_#{now}.csv"

    # export the filtered result into csv
    CSV.open(filename, "w") do |csv|
      csv << ["header","amino acid sequence","nucleotide sequence","group","organism","publish_date"]
      protein.each do |p|
        nt_object = CustomizedNucleotideSequence.find_by(:header => p.header)
        nt_sequence = ""
        if !nt_object.nil?
          nt_sequence = nt_object.chain
        end
        csv << [p.header,p.chain,nt_sequence,p.group,p.organism,p.update_date]
      end
    end

    return filename

	end


	# package the filtered result into fasta file, and zip it 
	# Params: CustomizedProteinSequence activerecord
	# For ProteinController#download_filtered_result_fasta
	# +command+:: 
	# +outhandler+:: +Proc+ 
	# +errhandler+:: +Proc+
	def package_fasta_for_filtered_result(protein)
		now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
    filename_protein = "tmp/filtered_result/filtered_#{now}_protein.fasta"
    filename_gene = "tmp/filtered_result/filtered_#{now}_gene.fasta"

		File.open(filename_protein, "w") do |f|
		  protein.each do |pt|
		    f << ">" + pt.header + "\n"
		    f << pt.chain + "\n"
		  end
		end

		File.open(filename_gene, "w") do |f|
		  protein.each do |pt|
		    gene = CustomizedNucleotideSequence.find_by(:header => pt.header)
		    if !gene.nil?
		      f << ">" + gene.header + "\n"
		      f << gene.chain + "\n"
		    end
		  end
		end

		zip_file = "tmp/filtered_result/filtered_#{now}.zip"
		Zip::File.open(zip_file, Zip::File::CREATE) { |zipfile|
		  zipfile.add("filtered_#{now}_protein.fasta","#{Rails.root}/#{filename_protein}")
		  zipfile.add("filtered_#{now}_gene.fasta","#{Rails.root}/#{filename_gene}")
		  # zipfile.get_output_stream("filtered")
		}

		return zip_file
	end


	def protein_index_just_filter(params, sort=nil, download=nil)
		accession = params[:accession]
		header    = params[:header]
		group     = params[:group]
		organism  = params[:organism]
		if accession.present? and !header.present? and !group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("header like ?", "%#{accession}%")
		elsif !accession.present? and header.present? and !group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("header like ?", "%#{header}%")
		elsif !accession.present? and !header.present? and group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("customized_protein_sequences.group like ?", "#{group}")
		elsif !accession.present? and !header.present? and !group.present? and organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("organism like ?", "%#{organism}%")
		elsif accession.present? and header.present? and !group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and header like ?", "%#{accession}%","%#{header}%")
		elsif accession.present? and !header.present? and group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and customized_protein_sequences.group like ?", "%#{accession}%","#{group}")
		elsif accession.present? and !header.present? and !group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and organism like ?", "%#{accession}%","%#{organism}%")
		elsif !accession.present? and header.present? and group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and group like ?", "%#{header}%","#{group}")
		elsif !accession.present? and header.present? and !group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and organism like ?", "%#{header}%","%#{organism}%")
		elsif !accession.present? and !header.present? and group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("group like ? and organism like ?", "#{group}","%#{organism}%")
		elsif accession.present? and header.present? and group.present? and !organism.present? # 3 field
		  protein = CustomizedProteinSequence.where("header like ? and header like ? and group like ?", "%#{accession}%", "%#{header}%", "#{group}")
		elsif accession.present? and header.present? and !group.present? and organism.present?
		  protein = CustomizedProteinSequence.where("header like ? and header like ? and organism like ?", "%#{accession}%", "%#{header}%", "%#{organism}%")
		elsif !accession.present? and header.present? and group.present? and organism.present?
		  protein = CustomizedProteinSequence.where("header like ? and group like ? and organism like ?", "%#{header}%", "#{group}", "%#{organism}%")
		else
		  protein = CustomizedProteinSequence.where("header like ? and header like ? and group like ? and organism like ?", "%#{accession}%", "%#{header}%", "#{group}","%#{organism}%")
		end

		if sort.nil?

			if download.nil?
				# no download; just render the page
				return protein.limit(25).page(params[:page])
			
			else # if download is not nil
				
				return protein
			
			end

		else
			sort_order = nil
			if params[:d] == "up"
			  sort_order = "asc"
			else
			  sort_order = "desc"
			end

			return protein.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
		end
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