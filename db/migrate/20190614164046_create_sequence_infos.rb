class CreateSequenceInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :sequence_infos do |t|
    	t.string :generic_id
    	t.string :origin
    	t.string :reference
    	t.string :type
    	t.date   :publish_date
    	t.string :organism
    	t.string :key
    	t.string :key_origin
      t.timestamps
    end
  end
end
