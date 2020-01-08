class ChangeTinyintToInt < ActiveRecord::Migration[5.2]
  def change
  	change_column :references, :strain_id, :int
  end
end
