# this file is for runner in /config/schedule.rb

module Cron

	def self.create_fasta
		# create fasta file for nt and aa 

	end


	def self.remove_tmp_fasta
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/database_fasta_db/*}"))
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/tmp_fasta/*}"))
	end


	def self.remove_tmp_csv
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/csv/*}"))

	end

	def self.remove_filtered_csv
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/filtered_result/*.csv}"))
	end

	def self.remove_filtered_fasta
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/filtered_result/*.fasta}")
	end

	def self.remove_filtered_zip
		FileUtils.rm_rf(Dir.glob("#{Rails.root}/tmp/filtered_result/*.zip}")
	end



end
