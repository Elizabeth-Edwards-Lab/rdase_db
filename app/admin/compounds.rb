ActiveAdmin.register Compound do
  permit_params :id, :public_id, :name, :smiles, :inchi, :inchikey, :created_at, :updated_at, :description, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description, :physical_description_reference, :percent_composition, :percent_composition_reference, :melting_point, :melting_point_reference, :boiling_point, :boiling_point_reference, :experimental_solubility, :experimental_solubility_reference, :experimental_logp, :experimental_logp_reference, :experimental_pka, :experimental_pka_reference, :charge, :charge_reference, :optical_rotation, :optical_rotation_reference, :uv_index, :uv_index_reference, :density, :density_reference, :refractive_index, :refractive_index_reference, :chemspider_id, :chembl_id, :kegg_compound_id, :pubchem_compound_id, :pubchem_substance_id, :chebi_id, :phenolexplorer_id, :drugbank_id, :hmdb_id, :dfc_id, :eafus_id, :bigg_id, :knapsack_id, :het_id, :wikipedia_id, :image
  form do |f|
    f.semantic_errors
    f.inputs do
        f.inputs :name, :smiles, :inchi, :inchikey, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description
        f.input :image, as: :file
    end
    f.actions
  end
  
  show do
    attributes_table do
      rows :name, :smiles, :inchi, :inchikey, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description
      row :image do |diag|
        image_tag url_for(diag.image) if diag.image.attached?
      end
    end
  end

  index do
    selectable_column
    column :name do |c|
      link_to c.name, admin_compound_path(c)
    end
    [:smiles, :inchi, :inchikey, :cas_number, :formula, :iupac, :average_mass, :mono_mass, :state, :physical_description].each do |c|
        column c.to_sym
    end
    column :image do |diag|
      if diag.image.attached?
        "✔"
      else
        "❌"
      end
    end
    actions
  end
end
