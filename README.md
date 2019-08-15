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

if you want to use ncbi-blast+ and perl script of legacy_blast, then
you don't need to worry about legacy_blast's default file path
but you need to change the path at config/initializers/blast.rb

def make_command_line
  path = "//usr/local/ncbi/blast/bin"  # CHANGE ME
  cmd = make_command_line_options
  cmd.unshift @blastall
  cmd.unshift "#{path}/legacy_blast.pl"    # ADDED
  cmd.push "--path"                        # ADDED
  cmd.push path                            # ADDED
  cmd
end

I guess have to run some sort script to replace the blast.rb for every deployment



## MacOS
Below instruction is for using old blastall program 
BioRuby still use blastall so currently have to use legacy_blast.pl

Use legacy_blast.pl in /usr/local/ncbi/blast/bin for ruby on rails
then override following function 
To override function from gem, create new file (with same name as original file) in config/initializers
And copy everything except making customized modification for overriding
See reference: https://stackoverflow.com/questions/580314/overriding-a-module-method-from-a-gem-in-rails

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


# how to deploy new changes on ubuntu
bundle exec cap production deploy # pull changes from repo
// change blast.rb and possible restart puma.sh
bundle exec cap production deploy:restart # apply the changes from blast.rb




If the system is under ubuntu, the following file should be modified
1. config/initializers/blast.rb => change back to original code because blastall exist in ubuntu
2. database.yml => change the location of msyql.sock due to installation place


#TODO List
1. filter database result + add link to each query => done
3. tree image + discard the sequence with *  => done

2. test the new query code => done (should be ok)
4. send results to email and new windows (don't put this into action item for now)
5. format the blast result () => done
6. rebuild blast database after new sequence inserted => done, just need to let user determine which group user need
7. adding loading animation => two animiations blast and tree =?
8. add statisitics for how many organism and group we have  => done
9. color the group at tree graph level
10. some gene id for ncbi is already outdated => only add NCBI direct assession 
11. format the submit sequence component => done
12. add reference for each sequence 
13. bug: the blastn won't work if the sequence is less than certain length
14. add submit multiple sequence feature (without polytree feature)












