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


	def package_csv_for_filtered_result(protein)
		
		now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
	  filename = "tmp/filtered_result/filtered_#{now}.csv"

	  # export the filtered result into csv
	  CSV.open(filename, "w") do |csv|
	    csv << ["protein header","protein accession number","amino acid sequence","nucleotide sequence","group","organism",
	    				"protein name", "is_characterized?","reference", "uploader"]
	    protein.each do |pro|

	    	reference = Reference.where(:strain_id => pro.id).select(:pubmed_id)
	    	reference_s = ""
	    	reference.each do |ref|
	    		reference_s += "#{ref.pubmed_id}|"
	    	end
	      nt_object = CustomizedNucleotideSequence.find_by(:protein_id => pro.id)
	      nt_sequence = ""
	      if !nt_object.nil?
	        nt_sequence = nt_object.chain
	      end
	      csv << [pro.header, pro.accession_no, pro.chain, nt_sequence, pro.group, pro.organism, 
	      			pro.protein_name, pro.characterized,reference_s, pro.uploader]
	    end
	  end

	  return filename

	end


	# package the filtered result into fasta file, and zip it 
	def package_fasta_for_filtered_result(protein)
		now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
		filename_protein = "tmp/filtered_result/filtered_#{now}_protein.fasta"
		filename_gene = "tmp/filtered_result/filtered_#{now}_gene.fasta"

		File.open(filename_protein, "w") do |f|
		  protein.each do |pt|
		  	f << "> #{pt.header} | #{pt.accession_no} | #{pt.organism} | #{pt.group} \n"
				f << "#{pt.chain}\n"
		  end
		end

		File.open(filename_gene, "w") do |f|
		  protein.each do |pt|
		    gene = CustomizedNucleotideSequence.find_by(:protein_id => pt.id)
		    if !gene.nil?
		      f << "> #{pt.header} | #{gene.accession_no} | #{pt.organism} | #{pt.group}\n"
		      f << "#{gene.chain}\n"
		    end
		  end
		end

		zip_file = "tmp/filtered_result/filtered_#{now}.zip"
		Zip::File.open(zip_file, Zip::File::CREATE) { |zipfile|
		  zipfile.add("filtered_#{now}_protein.fasta","#{Rails.root}/#{filename_protein}")
		  zipfile.add("filtered_#{now}_gene.fasta","#{Rails.root}/#{filename_gene}")
		}

		return zip_file
	end


	def protein_index_just_filter(params, sort=nil, download=nil)
		accession = params[:accession_no]
		header    = params[:header]
		group     = params[:group]
		organism  = params[:organism]
		if accession.present? and !header.present? and !group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("accession_no like ?", "%#{accession}%")
		elsif !accession.present? and header.present? and !group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("header like ?", "%#{header}%")
		elsif !accession.present? and !header.present? and group.present? and !organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("customized_protein_sequences.group like ?", "#{group}")
		elsif !accession.present? and !header.present? and !group.present? and organism.present? # 1 field
		  protein = CustomizedProteinSequence.where("organism like ?", "%#{organism}%")
		elsif accession.present? and header.present? and !group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("accession_no like ? and header like ?", "%#{accession}%","%#{header}%")
		elsif accession.present? and !header.present? and group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("accession_no like ? and customized_protein_sequences.group like ?", "%#{accession}%","#{group}")
		elsif accession.present? and !header.present? and !group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("accession_no like ? and organism like ?", "%#{accession}%","%#{organism}%")
		elsif !accession.present? and header.present? and group.present? and !organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and group like ?", "%#{header}%","#{group}")
		elsif !accession.present? and header.present? and !group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("header like ? and organism like ?", "%#{header}%","%#{organism}%")
		elsif !accession.present? and !header.present? and group.present? and organism.present? # 2 field
		  protein = CustomizedProteinSequence.where("group like ? and organism like ?", "#{group}","%#{organism}%")
		elsif accession.present? and header.present? and group.present? and !organism.present? # 3 field
		  protein = CustomizedProteinSequence.where("accession_no like ? and header like ? and group like ?", "%#{accession}%", "%#{header}%", "#{group}")
		elsif accession.present? and header.present? and !group.present? and organism.present?
		  protein = CustomizedProteinSequence.where("accession_no like ? and header like ? and organism like ?", "%#{accession}%", "%#{header}%", "%#{organism}%")
		elsif !accession.present? and header.present? and group.present? and organism.present?
		  protein = CustomizedProteinSequence.where("accession_no like ? and group like ? and organism like ?", "%#{header}%", "#{group}", "%#{organism}%")
		else
		  protein = CustomizedProteinSequence.where("accession_no like ? and header like ? and group like ? and organism like ?", "%#{accession}%", "%#{header}%", "#{group}","%#{organism}%")
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



	# identify the group of orth
	# puts "hit.query_len => #{hit.query_len}" # => original sequence length
	# puts "hit.query_seq.length => #{hit.query_seq.length}" # => hit sequence length
	def get_identity_with_90(aa_report)

		identity_with_90 = Array.new 
		aa_report.each do |hit|
			
		  match_identity = 0
		  if hit.query_len > hit.query_seq.length
		  	match_identity = (hit.identity.to_f / hit.query_seq.length.to_f * 100).round(2)
		  elsif hit.query_len < hit.query_seq.length
		  	match_identity = (hit.identity.to_f / hit.query_len.to_f * 100).round(2)
		  end

		  if match_identity >= 90.00
		    identity_with_90 << hit.target_def
		  end
		end

		return identity_with_90
	end



	def get_existing_groups(aa_report,sequence)
		is_exist_chain = false
		existing_matched_group = Array.new
		aa_report.each do |hit|
		  if hit.evalue == 0
		    existing_protein = CustomizedProteinSequence.find_by(:chain => sequence)
		    if !existing_protein.nil?
		      is_exist_chain = true
		      if !existing_protein.group.nil? and !existing_matched_group.include? existing_protein.group
		        existing_matched_group << existing_protein.group
		      end
		    end
		  end
		end

		return is_exist_chain, existing_matched_group
	end


	
	def get_characterized_member(group)
		final_characterized_member = Array.new
		all_characterized_strain_id = CompoundStrainRel.all.select('protein_id').map(&:protein_id).uniq
		group_members = CustomizedProteinSequence.where(:group => group)
		group_members.each do |group_m|
			if all_characterized_strain_id.include? group_m.id
				final_characterized_member << [group_m.id, group_m.header]
			end
		end
		return final_characterized_member
	end

	# be careful about _s at end of this function
	def get_characterized_member_s(group)
		if group.length == 1
			return get_characterized_member(group[0])
		else
			multiple = Array.new
			group.each do |g|
				tmp = get_characterized_member(g)
				multiple.push(*tmp) 
			end
			return multiple
		end
	end


	

	def describt_hit(hit)
		puts hit.evalue           # E-value
		puts hit.sw               # Smith-Waterman score (*)
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
		puts "============================================================="
	end

end