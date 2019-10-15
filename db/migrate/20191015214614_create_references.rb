class CreateReferences < ActiveRecord::Migration[5.1]
  def change
    create_table :references do |t|
    	t.integer   :pubmed_id
      t.string    :citation
      t.string    :doi
      t.string    :url
      
      t.timestamps
    end
  end
end
