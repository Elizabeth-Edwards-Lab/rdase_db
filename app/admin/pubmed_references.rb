ActiveAdmin.register PubmedReference, as: "Reference" do
  permit_params :pubmed_id, :citation, :doi, :url, :strain_id
  form do |f|
    f.semantic_errors
    f.inputs do
        f.inputs :pubmed_id, :citation, :doi, :url
        f.input :customized_protein_sequence
    end
    f.actions
end
end
