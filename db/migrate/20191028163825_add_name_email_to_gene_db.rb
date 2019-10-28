class AddNameEmailToGeneDb < ActiveRecord::Migration[5.2]
  def change
  	add_column :customized_nucleotide_sequences, :uploader_name, :string 
  	add_column :customized_nucleotide_sequences, :uploader_email, :string 
  end
end
