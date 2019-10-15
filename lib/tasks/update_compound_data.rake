namespace :update_compound_data do


	# rake update_compound_data:update_the_protein_rel
	desc 'remember: there are two names of the protein sequence => common name and NCBI accession number'
	desc 'this step should come after the protein table is fully uploaded'
	task :update_the_protein_rel => [:environment] do
		CSV.foreach("data/compound information.tsv", { :headers => true, :col_sep => "\t" }) do |row|
			inchikey = row[3]
			protein_id_from_OGdb = row[7]
			# create the reference table that contain all the reference
			pubmed_id = row[6]
			compound = Compound.find_by(:inchikey => inchikey)
			if compound.nil?
				puts row[1]
			else
				protein = CustomizedProteinSequence.find_by(:header => protein_id_from_OGdb)
				if protein.nil?
					puts row[7]
				else

					new_compound_str_rel = CompoundStrainRel.new 
					new_compound_str_rel.protein_id = protein.id
					new_compound_str_rel.rddb_id = compound.public_id
					new_compound_str_rel.header = protein.header
					new_compound_str_rel.compound_id = compound.id

					new_compound_str_rel.save!
				end


			end
		end
	end


	desc 'update the properties'
	# rake update_compound_data:update_the_properties
	task :update_the_properties =>[:environment] do


	end

	desc 'update the images'
	task :update_the_image =>[:environment] do


	end
 
end