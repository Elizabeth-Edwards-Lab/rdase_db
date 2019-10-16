class AddAccessionNoSpeciesProteinName < ActiveRecord::Migration[5.1]
  def change
  	add_column :customized_protein_sequences, :accession_no, :string 
  	add_column :customized_protein_sequences, :species, :string
  	add_column :customized_protein_sequences, :protein_name, :string

  	add_column :customized_nucleotide_sequences, :accession_no, :string 
  	add_column :customized_nucleotide_sequences, :species, :string
  	add_column :customized_nucleotide_sequences, :protein_name, :string

  end
end
