namespace :import_compound_information do


	# rake import_sequence_info:import_info
	task :import_compound => [:environment] do

		inchikey_pool = Array.new
		append_row = Array.new
		CSV.foreach("data/compound information.tsv", { :headers => true, :col_sep => "\t" }) do |row|
			inchikey = row[3]
			if !inchikey_pool.include? inchikey
				inchikey_pool << inchikey
				append_row << row
			end
		end

		append_row.each do |row|
			begin
				newcompound = Compound.new
				newcompound.name = row[0]
				newcompound.smiles = row[1]
				newcompound.inchi = row[2]
				newcompound.inchikey = row[3]
				newcompound.save!
			rescue
				puts row
			end
		end

  end


  task :remove_compound => [:environment] do
  	Compound.delete_all


  end




end