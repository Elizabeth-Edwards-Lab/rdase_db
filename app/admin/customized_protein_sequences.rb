ActiveAdmin.register CustomizedProteinSequence, as: "Protein Sequence" do
    permit_params :header, :chain, :uploader_id, :created_at, :updated_at, :group, :update_date, :publication_date, :tree_name, :key_group, :organism, :key, :uploader, :accession_no, :species, :protein_name, :uploader_name, :uploader_email, :characterized, :single, :pubmed_references, :compounds
    index do
        selectable_column
        excluded = ['chain', 'reference', 'uploader_id']
        (CustomizedProteinSequence.column_names - excluded).each do |c|
            column c.to_sym
        end
        column :chain do |p|
            p.chain.truncate(10, omission: "...")
        end
        actions
    end

    form do |f|
        f.semantic_errors
        f.inputs do
            f.inputs :header, :chain, :group, :tree_name, :key_group, :organism, :key, :uploader, :accession_no, :species, :protein_name
            f.input :characterized, as: :boolean
            f.input :single, as: :boolean
            
            f.input :pubmed_references
            f.input :compounds
        end
        f.actions
    end
end