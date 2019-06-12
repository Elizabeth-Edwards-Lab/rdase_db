class CreateUploaders < ActiveRecord::Migration[5.1]
  def change
    create_table :uploaders do |t|
      t.string :uploader_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :institution, null: false
      t.timestamps
    end
  end
end
