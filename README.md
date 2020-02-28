# RDaseDB Project
The Reductive Dehalogenase Database is a joint project from Wishart Lab Group at University of Alberta and Elizabeth Edwards Lab at University of Toronto. BLAST is a registered trademark of the National Library of Medicine.

# Schema Explanation
customized_nucleotide_sequences: original database + user uploaded sequence
customized_protein_sequences: original database + user uploaded sequence
queries: keep track of user's queries
uploaders: keep track of uploader's information

# Table Explanation
nucleotide_sequences: update_date and publication_date are different, make publication_date as primary reference.

# File Structure

## Rails file
app
bin
config
data
db
lib
log
public
test
storage => this is for ActiveStorage
tmp
vendor

## Customized File
references => contain all the tutorials, to-do list, papers.
index => contain blast database
script => contain puma script (for start the application)