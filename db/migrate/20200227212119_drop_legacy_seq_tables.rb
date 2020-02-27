class DropLegacySeqTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :protein_sequences
    drop_table :nucleotide_sequences
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end  
end
