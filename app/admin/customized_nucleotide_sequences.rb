ActiveAdmin.register CustomizedNucleotideSequence, as: "Nucleotide Sequence" do
  permit_params :id, :header, :chain, :updated_at, :reference, :group, :update_date, :publication_date, :tree_name, :key_group, :organism, :key, :uploader, :accession_no, :species, :protein_name, :uploader_name, :uploader_email, :protein_id
  index do
        selectable_column
        column :id do |c|
        link_to c.id, admin_nucleotide_sequence_path(c)
        end
        excluded = ['id', 'chain', 'reference', 'uploader_id']
      (CustomizedNucleotideSequence.column_names - excluded).each do |c|
          column c.to_sym
      end
      column :chain do |p|
          p.chain.truncate(10, omission: "...")
      end
      actions
  end
  
end
