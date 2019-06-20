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


# for blast+ installation
## ubuntu
apt update
apt upgrade
apt install ncbi-blast+-legacy
apt install ncbi-blast+

note: ubuntu doesn't need to worry about the issue from MacOS since the blastall program can be installed 
through apt install ncbi-blast+-legacy

## MacOS
Below instruction is for using old blastall program 
BioRuby still use blastall so currently have to use legacy_blast.pl

Use legacy_blast.pl in /usr/local/ncbi/blast/bin for ruby on rails
then override following function 
see reference: https://stackoverflow.com/questions/580314/overriding-a-module-method-from-a-gem-in-rails

module Bio
  class Blast
    def make_command_line
      path = "/path/to/ncbi-blast-2.9.0+/bin"  # CHANGE ME
      cmd = make_command_line_options
      cmd.unshift @blastall
      cmd.unshift "#{path}/legacy_blast.pl"    # ADDED
      cmd.push "--path"                        # ADDED
      cmd.push path                            # ADDED
      cmd
    end
  end
end

program = "blastn"
blast_options = "-m 8"

blaster = Bio::Blast.local(program, "#{Rails.root}/index/blast/#{database}", blast_options)
report = blaster.query(@sequence.seq)

IMPORTANT:
legacy_blast.pl use default /usr/bin for all executable blast program.
if use legacy_blast.pl, should modify the legacy_blast.pl