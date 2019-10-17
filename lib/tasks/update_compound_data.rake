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

		table = Hash.new
		CSV.foreach("data/compound/orthdb_compound_from_moldb.csv", { :headers => true }) do |row|
			# id, molecular_weight, exact_mass, inchikey
			table[row[0]] = row[3]
			compound = Compound.find_by(:inchikey => row[3])
			compound.average_mass = row[1]
			compound.mono_mass = row[2]
			compound.save!
		end

		CSV.foreach("data/compound/orthdb_compound_properties_moldb.csv", { :headers => true }) do |row|
			# id, structure_id, name, value, source 
			inchikey = table[row[1]]
			compound = Compound.find_by(:inchikey => inchikey)
			
			case row[2]
			# when "acceptor_count"
			#   compound.
			# when "atom_count"
			  
			# when "average_polarizability"
			  
			# when "bioavailability"
			
			# when "donor_count"

			# when "formal_charge"

			# when "ghose_filter"

			when "iupac"
				compound.iupac = row[3]
			# when "logp"

			# when "logs"

			# when "mddr_like_rule"

			# when "number_of_rings"

			# when "physiological_charge"

			# when "polar_surface_area"

			# when "refractivity"

			# when "rotatable_bond_count"

			# when "rule_of_five"

			# when "solubility"

			# when "traditional_iupac"

			# when "veber_rule"

			else
				next
			end

			compound.save!

		end
		# public_id
    # name
    # smiles
    # inchi
    # inchikey
    # description
    # cas_number
    # formula
    # iupac
    # average_mass
    # mono_mass
	    # state
	    # physical_description
	    # physical_description_reference
	    # percent_composition
	    # percent_composition_reference
	    # melting_point
	    # melting_point_reference
	    # boiling_point
	    # boiling_point_reference
	    # experimental_solubility
	    # experimental_solubility_reference
	    # experimental_logp
	    # experimental_logp_reference
	    # experimental_pka
	    # experimental_pka_reference
	    # charge
	    # charge_reference
	    # optical_rotation
	    # optical_rotation_reference
	    # uv_index
	    # uv_index_reference
	    # density
	    # density_reference
	    # refractive_index
	    # refractive_index_reference
    # chemspider_id
    # chembl_id
    # kegg_compound_id
    # pubchem_compound_id
    # pubchem_substance_id
    # chebi_id
    # phenolexplorer_id
    # drugbank_id
    # hmdb_id
    # dfc_id
    # eafus_id
    # bigg_id
    # knapsack_id
    # het_id
    # wikipedia_id


    CSV.foreach("data/compound/orthdb_compound_external_link_from_chemdb.csv", { :headers => true }) do |row|
    	# id	
    	# title	
    	# common_name	
    	# description	
    	# cas	
    	# pubchem_id	
    	# chemical_formula	
    	# weight	
    	# appearance	
    	# melting_point	
    	# boiling_point	
    	# density	
    	# solubility	
    	# specific_gravity	
    	# flash_point	
    	# vapour_pressure	
    	# route_of_exposure	
    	# target	
    	# mechanism_of_toxicity	
    	# metabolism	
    	# toxicity	
    	# lethaldose	
    	# carcinogenicity	
    	# use_source	
    	# min_risk_level	
    	# health_effects	
    	# symptoms	
    	# treatment	
    	# created_at	
    	# updated_at	
    	# interacting_proteins	
    	# wikipedia	
    	# uniprot_id	
    	# kegg_compound_id	
    	# omim_id	
    	# chebi_id	
    	# biocyc_id	
    	# ctd_id	
    	# stitch_id	
    	# drugbank_id	
    	# pdb_id # 40	
    	# actor_id	
    	# organism	
    	# export	
    	# metabolizing_proteins	
    	# transporting_proteins	
    	# moldb_smiles	
    	# moldb_formula	
    	# moldb_inchi	
    	# moldb_inchikey	#49
    	# moldb_average_mass	
    	# moldb_mono_mass	
    	# origin	
    	# state	
    	# logp	
    	# hmdb_id	
    	# chembl_id	
    	# chemspider_id	
    	# type	
    	# structure_image_file_name	
    	# structure_image_content_type	
    	# structure_image_file_size	
    	# structure_image_updated_at	
    	# biodb_id	
    	# synthesis_reference	
    	# structure_image_caption	
    	# chemdb_id	
    	# dsstox_id	
    	# toxcast_id	
    	# stoff_ident_origin	
    	# stoff_ident_id
    	compound = Compound.find_by(:inchikey => row[49])
    	compound.formula = row[6]
    	compound.cas_number = row[4]
    	compound.description = row[3] 
    	compound.chemspider_id = row[57]
    	compound.chembl_id = row[56]
    	compound.kegg_compound_id = row[33]
    	compound.pubchem_compound_id = row[5]
    	# compound.pubchem_substance_id 
    	compound.chebi_id = row[35]
    	# compound.phenolexplorer_id
    	compound.drugbank_id = row[39]
    	compound.hmdb_id = row[55]
    	# compound.dfc_id = 
    	# compound.eafus_id
    	# compound.bigg_id
    	# compound.knapsack_id
    	# compound.het_id
    	compound.wikipedia_id = row[31]
    	compound.save!
    end

	end

	desc 'update the images'
	# rake update_compound_data:update_the_image
	# done (2019_10_17)
	task :update_the_image =>[:environment] do
		compounds = Compound.all
		compounds.each do |com|
			begin
				com.image.attach(io: File.open("data/compound/small_image/#{com.inchikey}.png"), filename: "#{com.inchikey}.png")
			rescue
				puts com.inchikey
			end
		end
	end
 
end



































