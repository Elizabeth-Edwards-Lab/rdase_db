namespace :import_nt_data do
require 'csv'


	# rake import_nt_data:import_nt
	task :import_nt => [:environment] do

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

		# abort("Message goes here")


		# above tries to parse the file and put into dictionary that for extracting data
		# below tries to import sequence data and bind to above sequence information 


		separation = Array.new
		file_line = Array.new
		File.open("data/rdhA_all_nt_17-June-2019.fasta", "r") do |f|
			
			ind = 0
		  f.each_line do |line|
		  	file_line << line
		  	if line.include? '>'
		  		# record line
		  		separation << ind
		  	end
		  	ind += 1
		  end
		end


		separation << file_line.length
		split = Array.new
		(0..separation.length-1).step(1) do |n|

			split << [separation[n], separation[n+1]]
		end


		split.pop


		# unique_string = Array.new
		exception = Hash.new
		split.each { |x| 
			# puts file_line[x[0]].gsub(">","")
			record = file_line[x[0]].gsub(">","").gsub(/\n/,"").gsub(/\r/,"")
			sequence = ""
			# puts x[0], x[1]
			(x[0]+1..x[1]-1).step(1) do |n|
				# puts n
				# puts file_line[n]
				sequence << file_line[n].gsub(/\n/,"").gsub(/\r/,"")
			end
			# puts sequence
			# puts record
			# puts "#{x[0]} and #{x[1]}"

			begin
				n_seq = NucleotideSequence.new
				c_n_seq = CustomizedNucleotideSequence.new
				n_seq.header = record
				n_seq.chain  = sequence
				c_n_seq.header = record
				c_n_seq.chain  = sequence

				# [group_by_year,group,publication_date,reference,earliest_date]
				if !orth_naming[record].nil?
					# puts orth_naming[record]
					extraction = orth_naming[record]
					n_seq.group = extraction[1]
					n_seq.publication_date = extraction[2]
					n_seq.reference = extraction[3]
					n_seq.update_date = extraction[4]
					# \\\\
					c_n_seq.group = extraction[1]
					c_n_seq.publication_date = extraction[2]
					c_n_seq.reference = extraction[3]
					c_n_seq.update_date = extraction[4]
				end
				# rdh_information[name_tree.gsub(" ","")] = [organism,key,key_origin]
				if !rdh_information[record].nil?
					extraction = rdh_information[record]
					n_seq.organism = extraction[0]
					n_seq.tree_name = record
					n_seq.key = extraction[1]
					n_seq.key_group = extraction[2]
					# \\\\
					c_n_seq.organism = extraction[0]
					c_n_seq.tree_name = record
					c_n_seq.key = extraction[1]
					c_n_seq.key_group = extraction[2]
				end


				# puts n_seq.inspect
				# puts "===================="
				# puts c_n_seq.inspect

				n_seq.save!
				c_n_seq.save!
				puts "#{x[0]} and #{x[1]} saved!"
			rescue
				exception[record] = sequence
				puts record
				# puts exception.backtrace
			end

		}


		File.open("data/rdhA_all_nt_17-June-2019_exception.fasta", 'w') { |file| 


			exception.each do |key, array|
				file.write(">#{key}\n")
				file.write("#{array}\n") 
			end

		}
		



	end


	# rake import_nt_data:destory_all
	task :destory_all => [:environment] do
		NucleotideSequence.delete_all
  	CustomizedNucleotideSequence.delete_all
	end

end