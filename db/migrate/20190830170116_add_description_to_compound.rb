class AddDescriptionToCompound < ActiveRecord::Migration[5.1]
  def change

  	add_column :compounds, :description, :text
  end
end
