class CreateCompoundStrainRels < ActiveRecord::Migration[5.1]
  def change
    create_table :compound_strain_rels do |t|
      t.string   :strain_header, null: false
      t.string   :rddb_id, null: false
      t.string   :reference
      t.timestamps
    end
  end
end
