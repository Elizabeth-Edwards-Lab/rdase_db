namespace :import_sequence_info do


	# rake import_sequence_info:import_info
	task :import_info => [:environment] do

		date_dictionary = { 'Jan' => 1, 'Feb' => 2, 'Mar' => 3,
												'Apr' => 4, 'May' => 5, 'Jun' => 6,
												'Jul' => 7, 'Aug' => 8, 'Sep' => 9,
												'Oct' => 10, 'Nov' => 11, 'Dec' => 12}

		orth_naming = Hash.new
		CSV.foreach("data/ortholog_group_naming_09052016.csv") do |row|
			group_by_year = row[0].split("_")[0]
			group = row[1]
			gene_id = row[2]
			pub_date = row[3].split("-")
			reference = row[4]
			earl_date = row[5].split("-")


			# parse pub_date
			if pub_date.length == 2
				if !date_dictionary[pub_date[0]].nil?
					if pub_date[1] == "00"
						publication_date = "#{group_by_year}-#{date_dictionary[pub_date[0]]}-01"
					else
						publication_date = "#{group_by_year}-#{date_dictionary[pub_date[0]]}-#{pub_date[1]}"
					end
				else
					if pub_date[0] == "00"
						publication_date = "#{group_by_year}-#{date_dictionary[pub_date[1]]}-01"
					else
						publication_date = "#{group_by_year}-#{date_dictionary[pub_date[1]]}-#{pub_date[0]}"
					end
				end
			else
				# only contain year
				publication_date = "#{group_by_year}-00-00"
			end

			# parse earl_date
			if earl_date.length == 2
				if !date_dictionary[earl_date[0]].nil?
					if earl_date[1] == "00"
						earliest_date = "#{group_by_year}-#{date_dictionary[earl_date[0]]}-01"
					else
						earliest_date = "#{group_by_year}-#{date_dictionary[earl_date[0]]}-#{earl_date[1]}"
					end
				else
					if earl_date[0] == "00"
						earliest_date = "#{group_by_year}-#{date_dictionary[earl_date[1]]}-01"
					else
						earliest_date = "#{group_by_year}-#{date_dictionary[earl_date[1]]}-#{earl_date[0]}"
					end
				end
			else
				# only contain year
				earliest_date = "#{group_by_year}-00-00"
			end

			orth_naming[gene_id.gsub(" ","")] = [group_by_year,group,publication_date,reference,earliest_date]
		
		end

		rdh_information = Hash.new
		CSV.foreach("data/Reductive_dehalogenase_homologous_genes_curated_dataset_information.csv") do |row|
			name_tree = row[0]
			organism = row[1]
			key = row[2]
			key_origin = row[3]

			rdh_information[name_tree.gsub(" ","")] = [organism,key,key_origin]
			# puts rdh_information
		end

		# [group_by_year,group,publication_date,reference,earliest_date]
		orth_naming.each do |key, array|
			begin
				rdh_info = rdh_information[key]
				new_seq = SequenceInfo.new
				new_seq.generic_id = key
				new_seq.reference = array[3]
				new_seq.publish_date = array[2]

				if !rdh_info.nil?
					new_seq.organism = rdh_info[0]
					new_seq.key = rdh_info[1]
					new_seq.key_origin = rdh_info[2]
				end


				new_seq.save!
			rescue
				puts key
			end

		end

		

  end




end