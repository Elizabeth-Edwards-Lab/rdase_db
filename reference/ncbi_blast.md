# Create a new blast database

requirement: ncbi+blast installed in your machine; your fasta file
run as:
```
$ makeblastdb -in test.fsa -parse_seqids -blastdb_version 5 -taxid_map test_map.txt -title "Cookbook demo" -dbtype prot
```
This will create a blast protein database 

```
$ makeblastdb -in ~/db/nucleotide/Genus_species_DNA_cds.fasta -title Genus_species_DNA -dbtype nucl -out ~/db/nucleotide
```
This will create a blast gene database