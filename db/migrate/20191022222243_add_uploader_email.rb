class AddUploaderEmail < ActiveRecord::Migration[5.2]
  def change
  	add_column :customized_protein_sequences, :uploader_name, :string 
  	add_column :customized_protein_sequences, :uploader_email, :string 
  end
end
