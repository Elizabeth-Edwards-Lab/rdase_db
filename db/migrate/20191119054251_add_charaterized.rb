class AddCharaterized < ActiveRecord::Migration[5.2]
  def change
  	add_column :customized_protein_sequences, :characterized, :tinyint 
  end
end
