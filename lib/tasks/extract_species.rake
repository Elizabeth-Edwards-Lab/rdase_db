namespace :extract_species do


	# rake extract_species:extract_species_from_csv
	task :extract_species_from_csv => [:environment] do

		species = Array.new
		CSV.foreach("data/Reductive Dehalogenase Sequence Information.tsv", { :headers => true, :col_sep => "\t" }) do |row|
			header = row[2]
			existing_seq = CustomizedProteinSequence.find_by(:header => header)
			if existing_seq.nil?
				species << ["NULL"]
			else
				if existing_seq.organism.nil?
					species << ["NULL"]
				else

					species << [existing_seq.organism]
				end
			end
		end	

		CSV.open("data/extract_species_result.csv", 'w',{ :col_sep => "\t" } ) do |csv|
      species.each { |e| 
        csv << e
      }
    end

  end

end