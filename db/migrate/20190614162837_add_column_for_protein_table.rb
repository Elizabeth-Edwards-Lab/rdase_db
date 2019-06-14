class AddColumnForProteinTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :protein_sequences, :reference, :string
  	add_column :protein_sequences, :group, :integer
  	add_column :protein_sequences, :update_date, :date
  	add_column :protein_sequences, :publication_date, :date
  	add_column :protein_sequences, :tree_name, :string
  	add_column :protein_sequences, :key_group, :string
  	add_column :protein_sequences, :organism, :string
    add_column :protein_sequences, :key, :string


  	add_column :customized_protein_sequences, :reference, :string
  	add_column :customized_protein_sequences, :group, :integer
  	add_column :customized_protein_sequences, :update_date, :date
  	add_column :customized_protein_sequences, :publication_date, :date
  	add_column :customized_protein_sequences, :tree_name, :string
  	add_column :customized_protein_sequences, :key_group, :string
  	add_column :customized_protein_sequences, :organism, :string
    add_column :customized_protein_sequences, :key, :string

  	

  end
end
