class SimpleController < ApplicationController

	def contact
	end

	def statistics
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
	end

	def citation
	end

	def other_database
	end

	def help
	end
end