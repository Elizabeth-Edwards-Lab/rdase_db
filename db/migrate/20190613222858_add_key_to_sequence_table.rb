class AddKeyToSequenceTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :nucleotide_sequences, :key, :string
  	add_column :customized_nucleotide_sequences, :key, :string
  end
end
