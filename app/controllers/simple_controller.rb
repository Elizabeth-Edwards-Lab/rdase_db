require 'csv'

class SimpleController < ApplicationController

	def statistics
		@number_of_original_aa_sequence = ProteinSequence.all.length
		@number_of_original_nt_sequence = NucleotideSequence.all.length
		@number_of_cus_aa_sequence = CustomizedProteinSequence.all.length
		customized_nucleotide_sequence = CustomizedNucleotideSequence.all
		@number_of_cus_nt_sequence = customized_nucleotide_sequence.length
		@number_of_group = customized_nucleotide_sequence.distinct.pluck(:group).length - 1 # remove null
		@number_of_organism = customized_nucleotide_sequence.distinct.pluck(:organism).length - 1 # remove null
  		@number_of_compound = Compound.all.length
  	end

	def downloads
		# get last date of update strain
		@last_update_date = CustomizedProteinSequence.order("created_at DESC").limit(1)[0].created_at

	end

	def download_aa_original
		send_file 'data/2020_01_09_protein.fasta', :type => "application/fasta", :filename =>  "2020_01_09_protein.fasta"		
	end

	def download_nt_original
		send_file 'data/2020_01_09_gene.fasta', :type => "application/fasta", :filename =>  "2020_01_09_gene.fasta"		
	end

	def download_aa_cus
		sequence = CustomizedProteinSequence.all
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/tmp_fasta/rdhA_aa_all_customized_#{now}.fasta"

		File.open(filename, "w") do |f|
		  CustomizedProteinSequence.all.each do |pt|
		  	f << "> #{pt.header} | #{pt.accession_no} | #{pt.organism} | #{pt.group} \n"
				f << "#{pt.chain}\n"
		  end
		end

		send_file filename, :type => "application/fasta", :filename =>  "rdhA_aa_all_customized_#{now}.fasta"
	end


	def download_nt_cus
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/tmp_fasta/rdhA_nt_all_customized_#{now}.fasta"

		File.open(filename, "w") do |f|
		  CustomizedNucleotideSequence.all.each do |gene|
		  	f << "> #{gene.accession_no} \n"
		  	f << "#{gene.chain}\n"
		  end
		end

		send_file filename, :type => "application/fasta", :filename =>  "rdhA_nt_all_customized_#{now}.fasta"
	end


	def download_entry_table_nt_orignal_docx
		send_file "data/old-data/rdase_names_accessions_09052016.docx", :type => "application/docx", :filename =>  "Entry_Table_Gene.docx"
	end

	def download_entry_table_cus

		now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
	  filename = "tmp/filtered_result/filtered_#{now}.csv"

	  # export the filtered result into csv
	  CSV.open(filename, "w") do |csv|
	    csv << ["protein header","protein accession number","amino acid sequence","nucleotide sequence","group","organism",
	    				"protein name", "is_characterized?","reference", "uploader"]
	    CustomizedProteinSequence.all.each do |pro|

	    	reference = Reference.where(:strain_id => pro.id).select(:pubmed_id)
	    	reference_s = ""
	    	reference.each do |ref|
	    		reference_s += "#{ref.pubmed_id}|"
	    	end
	      nt_object = CustomizedNucleotideSequence.find_by(:protein_id => pro.id)
	      nt_sequence = ""
	      if !nt_object.nil?
	        nt_sequence = nt_object.chain
	      end
	      csv << [pro.header, pro.accession_no, pro.chain, nt_sequence, pro.group, pro.organism, 
	      			pro.protein_name, pro.characterized,reference_s, pro.uploader]
	    end
	  end

		send_file filename, :type => "application/csv", :filename =>  "Entry_Table_Gene_#{now}.csv"
		# File.delete("tmp/Entry_Table_Gene_Customized_#{now}.csv") if File.exist?("tmp/Entry_Table_Gene_Customized_#{now}.csv")
	end

	def citation
	end

	def other_database
	end

	def help
	end
end