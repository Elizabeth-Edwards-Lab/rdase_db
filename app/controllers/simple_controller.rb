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
			aa_fasta_file.write(s.header)
			aa_fasta_file.write("\n")
			aa_fasta_file.write(s.chain)
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
			aa_fasta_file.write(s.header)
			aa_fasta_file.write("\n")
			aa_fasta_file.write(s.chain)
			aa_fasta_file.write("\n")
		}

		aa_fasta_file.close

		send_file filename, :type => "application/fasta", :filename =>  filename
		
		File.delete(filename) if File.exist?(filename)
	end

	def citation
	end

	def other_database
	end

	def help
	end
end