class AddCompoundIdProteinIdToRelationTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :compound_strain_rels, :compound_id, :integer 
  	add_column :compound_strain_rels, :protein_id, :integer
  end
end
