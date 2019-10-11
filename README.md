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
13. bug: the blastn won't work if the sequence is less than certain length => fixed 2019-08-15
14. add submit multiple sequence feature (without polytree feature)

2019-09-08
download filtered fasta (done)
clickable blast result (done)
add oliva tree to front page (pending)
add group number legend for color
use p-placer (no need to use MUSCLE)


2019-09-14
1. sort the list in database page (done)
   if click the group, show the page with only these groups (Done)
2. add group in the tree [Done]
2.1 create the tree based on organism or group (Done)
3. remove the selection certiera of average aa group (Done => set aa similarity threshold to 0.0)
4. find all these NCBI accession number and link them at listing sequence page (=> public number (accession number) + common name)



create local ncbi protein database for the purpose of getting all accession number

download all the protein db file from ftp://ftp.ncbi.nlm.nih.gov/blast/db/
aggregate them into one big database https://www.ncbi.nlm.nih.gov/books/NBK279693/
then run the blast
<!-- run ./ncbi-blast-2.9.0+/bin/blastn at compute canada -->
`blastn –db nt –query nt.fsa –out results.out `
parse the results.out


Assign all entry with group number. If there is no group, then assign value as 0, 
and indicate that group 0 is the non-assigned group


2019-9-26
1. please move the blast alignment so it is the last thing on the result page after you blast a sequence
Status: Done 
Comment: I give user choice that they can either render everything at same page, or they can render the 
result at new page. I will add loading amination later on (note: NCBI using automatical refreshing technqiues)

2. change the statement for asking user to submit sequence
Status: Done

3. When I try sorting the RDases by group, could you please write something into the column for RDases which do not have a group so they appear last rather than first? For example "no group"
Status: Done
Comment: I set the strain without group as group 0; and I display the strain with group 0 as "No Group",
Hope that we won't have to use group 0 as OGs group;

4. The strain name should not be italicized under organism. only genus & species names.
Status: ongoing
Comment: I will do this after the characteristics is separated from organism name (e.g. Dehalogenimonas lykanthroporepellens BL-DC-9; Dehalococcoides mccartyi DCMB5)

5. We are still missing a column which indicates which sequences have been characterized ie VcrA, TceA, PceA ect.
Status: ongoing 
Comment: overlapping task 4. I will need the spreadsheet to be filled completely; then I can determine the VcrA, etc.
For example, Dehalogenimonas lykanthroporepellens BL-DC-9, I am not really sure is BL-DC-9 the characteristics or just a common name; same as Dehalococcoides mccartyi DCMB5 (DCMB5?)
Do you also want to sort the characteristics?

6. There is no link to OG group information right now....when we click on the OG# I thought we were going to have it take us to a page which describes whether the group has any characterized representatives and the references for those.
Status: ongoing
Comment: I didn't recall this requirement. Currently, if user click group number at any page, it will redirect user to
the protein database page but only displaying the group members

7. I'm not sure that "average AA similarity" is working like it is supposed to. I also tried blasting a sequence which I know is already in an OG and in the database and I got like 81% which makes no sense since it should be >90%.....
Status: Done
Comment: average AA similarity =  number of strain with blast hit (based on evalue) / total number of strain in database;
average AA similarity is not selectin criteria anymore, I should remove it...  

8. At the bottom of the page when we have the option to create a tree.....please change "All ORase group" to "All OGs". Could we also make an option to select more than one organism at one? Or maybe a separate option like "All Dehalococcoides" "All Dehalogenimonas" and "All Dehalobacter"
Status: ongoing
Comment: "All ORase group" to "All OGs" will do. 
          I will try to figure out how to let user select multiple groups and organisms (not easy task at client-side)


9. Implement the decision tree (from Dr.Edwards)

10. Complete the spreadsheet.
   For organism, extract information from existing database to fill the spreadsheet; then annotate
   


2019-10-11
1. finish add sequence to database (decision tree, loading animation)
  1. save the successful data into temporary file and return that file location
2. create tree based on organisms and number of groups
3. create the sequence and compound relationships and link them






