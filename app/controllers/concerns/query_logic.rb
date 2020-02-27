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
		genbank_id = params[:genbank_id]
		protein_name = params[:protein_name]
		# puts accession, header, group, organism, genbank_id

		protein = CustomizedProteinSequence.all

		if accession.present?
			protein = protein.where("accession_no like ?", "%#{accession}%")
		end

		if header.present?
			protein = protein.where("header like ?", "%#{header}%")
		end

		if organism.present?
			protein = protein.where("organism like ?", "%#{organism}%")
		end

		if group.present?
			protein = protein.where("customized_protein_sequences.group = ?", group.to_i)
		end

		if protein_name.present?
			protein = protein.where("protein_name like ?", "%#{protein_name}%")
		end

		if genbank_id.present?
			protein = protein.joins("left join customized_nucleotide_sequences on customized_nucleotide_sequences.protein_id = customized_protein_sequences.id")
											 .where("customized_nucleotide_sequences.accession_no like ?","%#{genbank_id}%")
		end

		if sort.nil?
			# just filter, no sort

			if download.nil?
				# no download; just render the page
				return protein.limit(25).page(params[:page])
			
			else # if download is not nil
				
				return protein
			
			end

		else
			# filter and sort...
			sort_order = nil
			protein_sorted = nil
			if params[:d] == "up"
			  sort_order = "asc"
			else
			  sort_order = "desc"
			end
			if params[:c] != "genbank_id"
				protein_sorted = protein.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
			else
				protein_sorted = protein.joins("left join customized_nucleotide_sequences on customized_nucleotide_sequences.protein_id = customized_protein_sequences.id")
												.order("customized_nucleotide_sequences.accession_no is NULL, customized_nucleotide_sequences.accession_no #{sort_order}").limit(25).page(params[:page])
			end

			return protein_sorted
		end
	end



	# identify the group of orth
	# puts "hit.query_len => #{hit.query_len}" # => original sequence length
	# puts "hit.query_seq.length => #{hit.query_seq.length}" # => hit sequence length
	def get_identity_with_90(aa_report)

		identity_with_90 = Array.new 
		# puts aa_report.inspect
		aa_report.each do |hit|
		  
		  match_identity = 0
		  if hit.query_len > hit.query_seq().length
		  	match_identity = (hit.identity.to_f / hit.query_seq().length.to_f * 100).round(2)
		  elsif hit.query_len < hit.query_seq().length
		  	match_identity = (hit.identity.to_f / hit.query_len.to_f * 100).round(2)
		  elsif hit.query_len == hit.query_seq().length
		  	match_identity = (hit.identity.to_f / hit.query_len.to_f * 100).round(2)
		  end
		  # puts "#{hit.target_def} => #{match_identity} => #{hit.identity}"
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

end