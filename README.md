# README

# Schema Explaination
customized_nucleotide_sequences: orignal database + user uploaded sequence
customized_protein_sequences: orignal database + user uploaded sequence
nucleotide_sequences: orignal database (forbid to change)
protein_sequences: orignal database (forbid to change)
queries: keep track of user's query
uploaders: keep track of uploaders' information


# Table Explaination
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




