class AddColumnForCompound < ActiveRecord::Migration[5.1]
  def change

  	# # foodb compound field
  	# id, legacy_id, type, public_id, name, export, state, annotation_quality, 
  	# description, cas_number, melting_point, protein_formula, protein_weight, 
  	# experimental_solubility, experimental_logp, hydrophobicity, isoelectric_point, 
  	# metabolism, kegg_compound_id, pubchem_compound_id, pubchem_substance_id, 
  	# chebi_id, het_id, uniprot_id, uniprot_name, genbank_id, wikipedia_id, 
  	# synthesis_citations, general_citations, comments, protein_structure_file_name, 
  	# protein_structure_content_type, protein_structure_file_size, protein_structure_updated_at, 
  	# msds_file_name, msds_content_type, msds_file_size, msds_updated_at, creator_id, updater_id, 
  	# created_at, updated_at, phenolexplorer_id, dfc_id, hmdb_id, duke_id, drugbank_id, bigg_id, 
  	# eafus_id, knapsack_id, boiling_point, boiling_point_reference, charge, charge_reference, 
  	# density, density_reference, optical_rotation, optical_rotation_reference, percent_composition, 
  	# percent_composition_reference, physical_description, physical_description_reference, 
  	# refractive_index, refractive_index_reference, uv_index, uv_index_reference, experimental_pka, 
  	# experimental_pka_reference, experimental_solubility_reference, experimental_logp_reference, 
  	# hydrophobicity_reference, isoelectric_point_reference, melting_point_reference, moldb_alogps_logp, 
  	# moldb_logp, moldb_alogps_logs, moldb_smiles, moldb_pka, moldb_formula, moldb_average_mass, 
  	# moldb_inchi, moldb_mono_mass, moldb_inchikey, moldb_alogps_solubility, moldb_id, moldb_iupac, 
  	# structure_source, duplicate_id, old_dfc_id, dfc_name, compound_source, flavornet_id, goodscent_id, 
  	# superscent_id, phenolexplorer_metabolite_id, kingdom, superklass, klass, subklass, direct_parent, 
  	# molecular_framework, chembl_id, chemspider_id, meta_cyc_id, foodcomex, phytohub_id

  	# # existing
  	# id, public_id, name, smiles, inchi, inchikey, 
  	# created_at, updated_at, description
  	add_column :compounds, :cas_number, :string
  	add_column :compounds, :formula, :string
  	add_column :compounds, :iupac, :string
  	add_column :compounds, :average_mass, :string
  	add_column :compounds, :mono_mass, :string
  	add_column :compounds, :state, :string
  	add_column :compounds, :physical_description, :string
  	add_column :compounds, :physical_description_reference, :string
  	add_column :compounds, :percent_composition, :string
  	add_column :compounds, :percent_composition_reference, :string
  	add_column :compounds, :melting_point, :string
  	add_column :compounds, :melting_point_reference, :string
  	add_column :compounds, :boiling_point, :string
  	add_column :compounds, :boiling_point_reference, :string
  	add_column :compounds, :experimental_solubility, :string
  	add_column :compounds, :experimental_solubility_reference, :string
  	add_column :compounds, :experimental_logp, :string
  	add_column :compounds, :experimental_logp_reference, :string
  	add_column :compounds, :experimental_pka, :string
  	add_column :compounds, :experimental_pka_reference, :string
  	add_column :compounds, :charge, :string
  	add_column :compounds, :charge_reference, :string
  	add_column :compounds, :optical_rotation, :string
  	add_column :compounds, :optical_rotation_reference, :string
  	add_column :compounds, :uv_index, :string
  	add_column :compounds, :uv_index_reference, :string
  	add_column :compounds, :density, :string
  	add_column :compounds, :density_reference, :string
  	add_column :compounds, :refractive_index, :string
  	add_column :compounds, :refractive_index_reference, :string

  	add_column :compounds, :chemspider_id, :string
  	add_column :compounds, :chembl_id, :string
  	add_column :compounds, :kegg_compound_id, :string
  	add_column :compounds, :pubchem_compound_id, :string
  	add_column :compounds, :pubchem_substance_id, :string
  	add_column :compounds, :chebi_id, :string
  	add_column :compounds, :phenolexplorer_id, :string
  	add_column :compounds, :drugbank_id, :string
  	add_column :compounds, :hmdb_id, :string
  	add_column :compounds, :dfc_id, :string
  	add_column :compounds, :eafus_id, :string
  	add_column :compounds, :bigg_id, :string
  	add_column :compounds, :knapsack_id, :string
  	add_column :compounds, :het_id, :string
  	add_column :compounds, :wikipedia_id, :string
  end
end
