namespace :add_missing_accession_no do


	# rake add_missing_accession_no:add_missing_accession
	task :add_missing_accession => [:environment] do

		species = Array.new
		CSV.foreach("data/MissingAccessionNumbers_Batch_search_of_123non_accession_no_nr_blastp.tsv", { :headers => true, :col_sep => "\t" }) do |row|
			header = row[0]
			accession_no = row[2]

			entry = CustomizedProteinSequence.find_by(:header => header)
			if entry.nil?
				puts header
			else
				entry.accession_no = accession_no
				entry.save!

			end
		end	

  end

end