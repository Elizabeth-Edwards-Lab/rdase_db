# Create a new blast database

requirement: ncbi+blast installed in your machine; your fasta file
run as:
```
$ makeblastdb -in test.fsa -parse_seqids -blastdb_version 5 -taxid_map test_map.txt -title "Cookbook demo" -dbtype prot
$ makeblastdb -in data/RdhA_all_aa_26-Feb-2020.fasta -parse_seqids -title "RDaseDB Project" -dbtype prot -out index/blast/reductive_dehalogenase_protein
```
This will create a blast protein database 

```
$ makeblastdb -in ~/db/nucleotide/Genus_species_DNA_cds.fasta -title Genus_species_DNA -dbtype nucl -out ~/db/nucleotide
$ makeblastdb -in data/RdhA_all_nt_26-Feb-2020.fasta  -title "RDaseDB Project Genus" -dbtype nucl -out index/blast/reductive_dehalogenase_gene
```
This will create a blast gene database