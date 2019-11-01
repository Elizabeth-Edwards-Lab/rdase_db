#TODO List


2019-10-31
1. ask for gene sequence for submitting jobs
2. make filter can select the No Group options (optimize the filter function)
3. make user submit accession_no + organism


Oliva Comment 2019-10-31
1. I like the new home page quick start, but I can't read the font please change colour
Comments: DONE

2. I would still prefer the banner to be visible right from the beginning. I think it will help orient new users without making them scroll down. We have to assume users have no idea what's going on when they first open the page.
Comments: DONE. Banner is still there. When the page shrinks (especially when you use phone), the banner will disappear; but, I added a little button to view all the options even the page is shrinked.

3. Please force users to submit DNA sequence. The point of this database is to be better than NCBI. Users need to submit as at least as good as NCBI data and metadata....and ideally better! speaking of which.....can we have a box where a user can write their annotation and compound information for the dehalogenase they are submitting? If they have it.
Comments: will do. This will take a while to implement. I also need to assume user understand that when they submit, they need to keep the header same for gene sequence and aa sequence. 
In terms of compounds information, I can create another page for only submitting compounds information (which will take a while to implement). I just think if put everything in one page, it will be too much for user.


4. For the blast result page please put blast alignment as the last thing on the blast result page. Users will have problems finding the tree building button at the bottom otherwise.
Comments: DONE

5. If I blast a sequence which has no group the blast result page says "No Matching OD Group" This should say "No matching orthologous group". On this same page "Number returning sequence" should say "Number of aligned sequences" also The blast result page says "Blasting Result for ####" this should just say "Blast results for"
Comments: DONE

6. I keep making suggestions regarding making it easy for users to find out whether an OG has been biochemically characterized. None of these have been implemented. This is really important. Biochemical information is going to be one of the most sought after pieces of information by users. Please implement one. some of my previous suggestions included:
- on the blast result page immediately indicating whether or not the matching OG has any characterized members. This could be a link to an info page
Comments: I added following: 
         if the blast sequence match any group, it will show whether the matching OG has any characterized members, and link to those members

- on the sequence list page a column to indicate whether an OG has been characterized, and a link to that information. characterized RDases could also be identified by name ie TceA
Comments: I thought to use "Yes" or "No" indicate whether the chain is characterized. 
         I thought TceA is protein name; and I also thought if the chain has associated compounds, then it is characterized.


- or being able to click right on the OG # to get to a page where you get information about the OG from the current sequence page
Comments: when you click the OG #, you will get a page with only that group. Do you want to create pages that only describe the OG # ?


7. genus and species need to be in italics
Comment: DONE


2019-10-28
1. create the staging server after the site is published => DONE
2. make sure the no group can be selected => DONE
3. add characteristics on browsing database  => DONE
4. request organism name, ncbi accession number, reference (optional) in submitting annotated stuff => PENDING
5. remove the selection certeria for nt level at 90% => DONE
6. ask for gene sequence for submitting jobs => PENDING 
7. prettify the statistics page => DONE
8. create the template for associated compound and strains. => DONE
9. set up email => Working on it
10. prettify the sequence viewer => DONE

Comment:
For point 4:
	If user want to include species informatioon, they have to include them in the heading of fasta sequence.
	Reason: something like this:
	> Accession No | Organism | Insitution
	> Your sequence...
For point 6:
	If user want to send gene sequence, they have to send through email.
	Reason: Since the selection requirement doesn't require gene identity anymore, I think this is no longer necessary in short term. I understand that different gene sequences (even after transcription and translation, the protein sequences are same), will cause different protein folding.






PAST
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
  1. save the successful data (with group information) into temporary file and return that file location
  maybe save as json file; and read as json file.
  2. ask about if shorter version of sequence would work. e.g. MGKFHLTLSRRDFMKSLGLAGAGLATVKVGTPVFHD is in db g7
  how about MGKFHLTLSRRDFMKSLGLAGAGLATVK is also g7 but not db
2. create tree based on organisms and number of groups => groups and organisms can be pass to back-end
3. update the compound and protein information => Done; but there are still some sequences are not found in fasta
4. create the sequence and compound relationships and link them; => Done; need to make the linkage looks better
5. also update the download contents 
6. recreate the Blast database (DONE)


About submit sequence:
Here is the protocol:
Ask if user have the accession number of their sequence
if No  => deny the request or ask them to send to our lab
if Yes => ask them if their sequence have FeS binding and TAT peptide
  if No => send to our lab
  if Yes => show page for user to upload their sequence

After evaluation, upload the successful sequence to database automatically (with user email and name)
For failed sequence, send to lab for further analysis









