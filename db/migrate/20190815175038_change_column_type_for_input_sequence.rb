class ChangeColumnTypeForInputSequence < ActiveRecord::Migration[5.1]
  def change
  	change_column :queries, :sequence, :longtext
  	
  end
end
