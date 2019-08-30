class CreateCompounds < ActiveRecord::Migration[5.1]
  def change
    create_table :compounds do |t|
    	t.string     :public_id, null: false
    	t.string     :name, null: false
    	t.string     :smiles
    	t.string     :inchi
    	t.string     :inchikey, null: false
      t.timestamps
    end
  end
end
