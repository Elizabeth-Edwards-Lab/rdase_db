class CreateProteinSequences < ActiveRecord::Migration[5.1]
  def change
    create_table :protein_sequences do |t|
      t.string   :header
      t.text     :chain
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string 	 :uploader
      t.timestamps
    end
  end
end
