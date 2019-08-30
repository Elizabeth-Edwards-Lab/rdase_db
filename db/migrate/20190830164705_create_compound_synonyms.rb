class CreateCompoundSynonyms < ActiveRecord::Migration[5.1]
  def change
    create_table :compound_synonyms do |t|

      t.timestamps
    end
  end
end
