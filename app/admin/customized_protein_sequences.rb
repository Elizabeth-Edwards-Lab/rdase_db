ActiveAdmin.register CustomizedProteinSequence, as: "Protein Sequence" do
    permit_params :id, :header, :chain, :uploader_id, :created_at, :updated_at, :reference, :group, :update_date, :publication_date, :tree_name, :key_group, :organism, :key, :uploader, :accession_no, :species, :protein_name, :uploader_name, :uploader_email, :characterized, :single
    index do
        selectable_column
        excluded = ["chain"]
        (CustomizedProteinSequence.column_names - excluded).each do |c|
            column c.to_sym
        end
        column :chain do |p|
            p.chain.truncate(10, omission: "...")
        end
        actions
    end
end