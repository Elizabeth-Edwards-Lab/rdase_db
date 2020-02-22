ActiveAdmin.register Compound do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :public_id, :name, :smiles, :inchi, :inchikey, :description, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description, :physical_description_reference, :percent_composition, :percent_composition_reference, :melting_point, :melting_point_reference, :boiling_point, :boiling_point_reference, :experimental_solubility, :experimental_solubility_reference, :experimental_logp, :experimental_logp_reference, :experimental_pka, :experimental_pka_reference, :charge, :charge_reference, :optical_rotation, :optical_rotation_reference, :uv_index, :uv_index_reference, :density, :density_reference, :refractive_index, :refractive_index_reference, :chemspider_id, :chembl_id, :kegg_compound_id, :pubchem_compound_id, :pubchem_substance_id, :chebi_id, :phenolexplorer_id, :drugbank_id, :hmdb_id, :dfc_id, :eafus_id, :bigg_id, :knapsack_id, :het_id, :wikipedia_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:public_id, :name, :smiles, :inchi, :inchikey, :description, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description, :physical_description_reference, :percent_composition, :percent_composition_reference, :melting_point, :melting_point_reference, :boiling_point, :boiling_point_reference, :experimental_solubility, :experimental_solubility_reference, :experimental_logp, :experimental_logp_reference, :experimental_pka, :experimental_pka_reference, :charge, :charge_reference, :optical_rotation, :optical_rotation_reference, :uv_index, :uv_index_reference, :density, :density_reference, :refractive_index, :refractive_index_reference, :chemspider_id, :chembl_id, :kegg_compound_id, :pubchem_compound_id, :pubchem_substance_id, :chebi_id, :phenolexplorer_id, :drugbank_id, :hmdb_id, :dfc_id, :eafus_id, :bigg_id, :knapsack_id, :het_id, :wikipedia_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
