class ChangeUploaderType < ActiveRecord::Migration[5.1]
  def change
  	add_column :customized_protein_sequences, :uploader, :string, null: :false
  	add_column :customized_nucleotide_sequences, :uploader, :string, null: :false
  end
end
