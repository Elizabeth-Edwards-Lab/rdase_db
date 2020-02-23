namespace :import_aa_nt_data_2020_2_22 do
    desc 'All'
    task all: [:reinitialize_db, :import_aa_nt, :construct_metabolite_protein]

	# rake import_aa_nt_data_2020_2_22:import_aa_nt
	task :import_aa_nt => [:environment] do
		# ind = 0
		wrong_entry = Array.new
		CSV.foreach("data/20200222_RDase_Database.csv", {headers: true}) do |row|
			# ind = ind+=1
			# puts "#{ind}"

			begin
				orth_group = row[0].gsub("S-","").to_i
				old_gene_id = row[1]
				protein_accession_no = row[2].gsub(".1","").gsub(".2","")
				gene_accession_no = row[3].gsub(".1","").gsub(".2","")
				ref_pmid = row[4]
				organism = row[5]
				char_function = row[6]
				nt_seq = row[7]
                aa_seq = row[8]

				if old_gene_id == "none"
					old_gene_id = "None"
                end
                
                if not gene_accession_no
                    gene_accession_no = "None"
                end

				# save protein info; if old_gene_id is None, then display the protein_accession_no on the show page
				new_aa_seq = CustomizedProteinSequence.new
				new_aa_seq.header = old_gene_id
				new_aa_seq.chain = aa_seq
				new_aa_seq.group = orth_group
				new_aa_seq.organism = organism
				new_aa_seq.uploader = "RDaseDB"
				new_aa_seq.accession_no = protein_accession_no
				new_aa_seq.protein_name = char_function
				new_aa_seq.single = 1 if row[0].include? "S-"
				new_aa_seq.save!
				new_aa_seq_id = new_aa_seq.id

				# reference
				if ref_pmid.include? ","
					pmid = ref_pmid.split(",")
					
					pmid.each do |pd|
						ref = Reference.new
						ref.pubmed_id = pd.strip
						ref.strain_id = new_aa_seq_id
						ref.save!
					end
				elsif ref_pmid != "Unpublished"
					ref = Reference.new
					ref.pubmed_id = ref_pmid.strip
					ref.strain_id = new_aa_seq_id
					ref.save!
                end

				# nt sequence
				new_nt_seq = CustomizedNucleotideSequence.new
				new_nt_seq.protein_id = new_aa_seq_id
				new_nt_seq.chain = nt_seq
				new_nt_seq.accession_no = gene_accession_no
				new_nt_seq.uploader = "RDaseDB"
				new_nt_seq.save!
				# puts "#{ind} finished"
			rescue => e
				# puts e.backtrace
				# puts old_gene_id
				# puts "-----------"
				wrong_entry << row
			end
		end

		CSV.open("data/Final_RDaseDB_Database_exception.csv", 'w') do |csv|
			wrong_entry.each do |e|
				csv << e
			end
		end

	end

	# rake import_aa_nt_data_2020_2_22:reinitialize_db
	task :reinitialize_db => [:environment] do
		CustomizedNucleotideSequence.delete_all
		CustomizedProteinSequence.delete_all
		NucleotideSequence.delete_all
		ProteinSequence.delete_all
		CompoundStrainRel.delete_all
		Reference.delete_all

		CustomizedNucleotideSequence.destroy_all
		CustomizedProteinSequence.destroy_all
		NucleotideSequence.destroy_all
		ProteinSequence.destroy_all
		CompoundStrainRel.destroy_all
		Reference.destroy_all

		CompoundStrainRel.delete_all
		CompoundStrainRel.destroy_all
        ActiveRecord::Base.connection.truncate(:compound_strain_rels)
        
		ActiveRecord::Base.connection.truncate(:customized_protein_sequences)
		ActiveRecord::Base.connection.truncate(:customized_nucleotide_sequences)
		ActiveRecord::Base.connection.truncate(:references)
		ActiveRecord::Base.connection.truncate(:compound_strain_rels)
	end

	# rake import_aa_nt_data_2020_2_22:construct_metabolite_protein
	task :construct_metabolite_protein => [:environment] do

		CSV.foreach("data/strain_rddb_id_rel.csv") do |row|
			begin
				compound = Compound.find_by(:public_id => row[2])
				# protein = CustomizedProteinSequence.where(:chain => row[1])
				protein = CustomizedProteinSequence.where(:header => row[0])
				protein_id = nil
				protein_header = nil
				if protein.length == 1
					construct_protein_compound_rel(compound,protein[0])
				else
					# puts "zero/more returns => #{row[0]}"
                end
                
			rescue => e
				puts "error => #{row[0]}"
			end

		end
		
	end

	def construct_protein_compound_rel(compound,protein)
			new_rel  = CompoundStrainRel.new
			new_rel.compound_id = compound.id
			new_rel.protein_id = protein.id
			new_rel.rddb_id = compound.public_id
			new_rel.strain_header = protein.header
			new_rel.save!
		end

end