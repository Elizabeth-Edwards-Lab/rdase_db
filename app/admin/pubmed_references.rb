ActiveAdmin.register PubmedReference, as: "Reference" do
  permit_params :pubmed_id, :citation, :doi, :url, :strain_id
  
end
