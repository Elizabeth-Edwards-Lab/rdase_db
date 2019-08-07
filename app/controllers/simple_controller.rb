require 'csv'
class SimpleController < ApplicationController

	def contact
	end

	def statistics
		@number_of_original_aa_sequence = ProteinSequence.all.length
		@number_of_original_nt_sequence = NucleotideSequence.all.length
		@number_of_cus_aa_sequence = CustomizedProteinSequence.all.length
		@number_of_cus_nt_sequence = CustomizedNucleotideSequence.all.length
  	end

	def downloads


	end

	def download_aa_original
		send_file 'data/rdhA_all_aa_17-June-2019.fasta', :type => "application/fasta", :filename =>  "rdhA_all_aa_17-June-2019.fasta"		
	end

	def download_nt_original
		send_file 'data/rdhA_all_nt_17-June-2019.fasta', :type => "application/fasta", :filename =>  "rdhA_all_nt_17-June-2019.fasta"		
	end

	def download_aa_cus
		sequence = CustomizedProteinSequence.all
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/rdhA_aa_all_customized_#{now}.fasta"
		aa_fasta_file = File.open(filename,"w")

		sequence.each{ |x|
			aa_fasta_file.write(">")
			aa_fasta_file.write(x.header)
			aa_fasta_file.write("\n")
			aa_fasta_file.write(x.chain)
			aa_fasta_file.write("\n")
		}

		aa_fasta_file.close

		send_file filename, :type => "application/fasta", :filename =>  filename
		
		File.delete(filename) if File.exist?(filename)
	end


	def download_nt_cus
		sequence = CustomizedNucleotideSequence.all
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/rdhA_nt_all_customized_#{now}.fasta"
		aa_fasta_file = File.open(filename,"w")

		sequence.each{ |x|
			aa_fasta_file.write(">")
			aa_fasta_file.write(x.header)
			aa_fasta_file.write("\n")
			aa_fasta_file.write(x.chain)
			aa_fasta_file.write("\n")
		}

		aa_fasta_file.close

		send_file filename, :type => "application/fasta", :filename =>  filename
		
		File.delete(filename) if File.exist?(filename)
	end


	def download_entry_table_nt_orignal_docx
		send_file "data/rdase_names_accessions_09052016.docx", :type => "application/docx", :filename =>  "Entry_Table_Gene.docx"
	end


	def download_entry_table_nt_orignal_csv
		sequence = NucleotideSequence.all
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/csv/Entry_Table_Gene_#{now}.csv"
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		CSV.open(filename, 'wb') do |csv|
			csv << ["Table S1: Reductive dehalogenase homologous genes curated dataset information, with tree identifiers linked to NCBI, JGI, or in-house accession numbers and organism of origin."]
			csv << ["Name On Tree", "Organism","Key","What Key Is"]
			sequence.each  do |s|
				csv << [s.header, s.organism, s.key, s.key_group]
			end
		end

		send_file filename, :type => "application/csv", :filename =>  "Entry_Table_Gene_#{now}.csv"
		# File.delete("tmp/Entry_Table_Gene_#{now}.csv") if File.exist?("tmp/Entry_Table_Gene_#{now}.csv")
	end

	def download_entry_table_cus
		sequence = CustomizedNucleotideSequence.all
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		filename = "tmp/csv/Entry_Table_Gene_Customized_#{now}.csv"
		# name of the tree; organism; key; what key is;
		now = Time.now.strftime("%Y_%m_%d_%H_%M")
		CSV.open(filename, 'wb') do |csv|
			csv << ["Table S1: Reductive dehalogenase homologous genes curated dataset information, with tree identifiers linked to NCBI, JGI, or in-house accession numbers and organism of origin."]
			csv << ["Name On Tree", "Organism","Key","What Key Is"]
			sequence.each  do |s|
				csv << [s.header, s.organism, s.key, s.key_group]
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