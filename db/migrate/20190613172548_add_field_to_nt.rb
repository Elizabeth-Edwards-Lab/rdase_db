class AddFieldToNt < ActiveRecord::Migration[5.1]
  def change
  	add_column :nucleotide_sequences, :reference, :string
  	add_column :nucleotide_sequences, :group, :integer
  	add_column :nucleotide_sequences, :update_date, :date
  	add_column :nucleotide_sequences, :publication_date, :date
  	add_column :nucleotide_sequences, :tree_name, :string
  	add_column :nucleotide_sequences, :key_group, :string
  	add_column :nucleotide_sequences, :organism, :string

  	add_column :customized_nucleotide_sequences, :reference, :string
  	add_column :customized_nucleotide_sequences, :group, :integer
  	add_column :customized_nucleotide_sequences, :update_date, :date
  	add_column :customized_nucleotide_sequences, :publication_date, :date
  	add_column :customized_nucleotide_sequences, :tree_name, :string
  	add_column :customized_nucleotide_sequences, :key_group, :string
  	add_column :customized_nucleotide_sequences, :organism, :string
  end
end
