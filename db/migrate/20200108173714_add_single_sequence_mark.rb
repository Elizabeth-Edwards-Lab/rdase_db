class AddSingleSequenceMark < ActiveRecord::Migration[5.2]
  def change
  	add_column :customized_protein_sequences, :single, :tinyint 
  end
end
