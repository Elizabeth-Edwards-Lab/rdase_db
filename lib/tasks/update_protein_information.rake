namespace :update_protein_information do


	# rake update_protein_information:update_pro
	desc 'remember: there are two names of the protein sequence => common name and NCBI accession number'
	task :update_pro => [:environment] do
		CSV.foreach("data/Reductive_Dehalogenase_Sequence_Information_2019_10_16.tsv",  { :headers => true, :col_sep => "\t" }) do |row|
			# Group by year	
			# RD Group	
			# Gene ID	 #AKA common name
			# Accession No	
			# New locus tag	
			# Publication date	
			# Reference	
			# Earliest Date	
			# Name on tree Perez de Mora et al.	
			# Note1	
			# Note2	
			# Spcies 	11
			# Organism/strain	 12
			# Protein Name	
			# Characteristics

			# table schema
			# t.string "header"
			# t.text "chain"
			# t.integer "uploader_id"
			# t.datetime "created_at", null: false
			# t.datetime "updated_at", null: false
			# t.string "reference"
			# t.integer "group"
			# t.date "update_date"
			# t.date "publication_date"
			# t.string "tree_name"
			# t.string "key_group"
			# t.string "organism"
			# t.string "key"
			# t.string "uploader"
			# t.string "accession_no"
			# t.string "species"
			# t.string "protein_name"
			protein = CustomizedProteinSequence.find_by(:header => row[2])
			missing_strain_to_add = ["CG1_X792_01510","CG1_X792_07250","CG1_X792_07460"]
			aa_array = Array.new
			File.foreach("data/rdhA_all_aa_16-Oct-2019_missing.fasta") { |line|  
				aa_array << line.gsub(">","").gsub(/\s+/,"")
			}
			nt_array = Array.new
			File.foreach("data/rdhA_all_nt_16-Oct-2019_missing.fasta") { |line|  
				nt_array << line.gsub(">","").gsub(/\s+/,"")
			}


			if protein.nil?
				puts row[2]
				if missing_strain_to_add.include? row[2]
					# create new strain
					array_idx = aa_array.find_index(row[2])
					# puts array_idx
					new_protein = CustomizedProteinSequence.new 
					new_protein.header = row[2]
					new_protein.chain = aa_array[array_idx + 1]
					new_protein.reference = row[6]
					new_protein.group = row[1].to_i
					new_protein.organism = row[12]
					new_protein.species = row[11]
					if row[13].present?
						new_protein.protein_name = row[13]
					else
						new_protein.protein_name = nil
					end

					if row[3].present?
						accession_num = row[3]
						if row[3].include? '.'
							accession_num = row[3].split(".")[0]
						end

						new_protein.accession_no = accession_num

					else
						new_protein.accession_no = nil
					end
					new_protein.uploader = "RDaseDB"
					new_protein.save!

					array_idx = nt_array.find_index(row[2])
					new_nt = CustomizedNucleotideSequence.new
					new_nt.header = row[2]
					new_nt.chain = nt_array[array_idx + 1]
					new_nt.reference = row[6]
					new_nt.uploader = "RDaseDB"
					new_nt.save!
				end




			else
				protein.group = row[1].to_i
				protein.reference = row[6] # this need to change to pubmed id
				protein.species = row[11]
				protein.organism = row[12]
				
				if row[13].present?
					protein.protein_name = row[13]
				else
					protein.protein_name = nil
				end

				if row[3].present?
					accession_num = row[3]
					if row[3].include? '.'
						accession_num = row[3].split(".")[0]
					end

					protein.accession_no = accession_num

				else
					protein.accession_no = nil
				end

				protein.save!


			end

		end 


	end

end
























