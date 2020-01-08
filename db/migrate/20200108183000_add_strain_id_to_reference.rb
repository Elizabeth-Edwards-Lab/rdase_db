class AddStrainIdToReference < ActiveRecord::Migration[5.2]
  def change
  	add_column :references, :strain_id, :tinyint 
  end
end
