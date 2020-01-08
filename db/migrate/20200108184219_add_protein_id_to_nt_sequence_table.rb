class AddProteinIdToNtSequenceTable < ActiveRecord::Migration[5.2]
  def change
	add_column :customized_nucleotide_sequences, :protein_id, :int 
  end
end
