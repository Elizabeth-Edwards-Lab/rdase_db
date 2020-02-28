# The Reductive Dehalogenase Database Project
The RDaseDB is a freely available electronic database containing a curated, comprehensive set of amino acid and nucleotide sequences of reductive dehalogenase enzymes.

Please see [LICENSE.md](LICENSE.md) for use of data.


## Schema Explanation
    customized_nucleotide_sequences: original
    database + user uploaded sequence
    customized_protein_sequences: original
    database + user uploaded sequence
    queries: keep track of user's queries
    uploaders: keep track of uploader's information

## Table Explanation
    nucleotide_sequences update_date and publication_date are different, make publication_date as primary reference.

## File Structure

### Rails file
Uses standard Rails 5.x application structure

### Customized File
    references => contain all the tutorials, to-do list, papers.
    index => contain blast database
    script => contain puma script (for start the application)

## Citing the Database

> Molenda et al. 2020, Environ Sci-Proc Imp.

## Project Partners

> The Reductive Dehalogenase Database is a joint project from [Elizabeth Edwards' Lab](https://www.labs.chem-eng.utoronto.ca/edwards/) in the BioZone Centre for Applied Bioscience and Bioengineering at the University of Toronto and [Wishart Lab Group](http://www.wishartlab.com/) at University of Alberta. BLAST is a registered trademark of the [National Library of Medicine](https://www.nlm.nih.gov/).