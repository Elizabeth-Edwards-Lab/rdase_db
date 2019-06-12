class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
      t.string  :sequence
      t.integer :query_range_up
      t.integer :query_range_down
      t.string  :job_title
      t.string  :database
      t.string  :organism
      t.string  :report_format
      t.string  :algorithm
      t.string  :email
      t.boolean :file_upload

      
      t.timestamps
    end
  end
end
