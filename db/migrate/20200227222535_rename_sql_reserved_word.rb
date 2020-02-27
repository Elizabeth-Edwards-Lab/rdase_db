class RenameSqlReservedWord < ActiveRecord::Migration[5.2]
  def change
    rename_table :references, :pubmed_references
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end    
end
