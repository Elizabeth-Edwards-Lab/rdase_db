class SubmitSequenceController < ApplicationController

	include SequenceSubmitter
	# skip_before_action :verify_authenticity_token #if you skip before action, you will likely cause security violation


	# Use ajax strategy for clean page design
	def submit
		# puts params.inspect

		fasta_array = Array.new
		puts params.inspect
		if params[:sequence].present?
			# puts "params[:sequence] => #{params[:sequence]}"
			fasta_array = params[:sequence].scan(/>[^>]*/)
			if fasta_array.length == 0 

				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)

				# save_result_to_db(@uploading_result,fasta_array)

				render json: { "result": @uploading_result, "fasta": fasta_array }

			end

		elsif !params[:fasta].nil?
			# make sure that once upload the file, user can't insert any sequence
			uploaded_io = params[:fasta]
			puts uploaded_io
			now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
			file_name = uploaded_io.original_filename.gsub(".fasta","#{now}.fasta")
			# file_path = Rails.root.join('public', 'uploads/', file_name)
			# puts uploaded_io.read contains the content of file; no need to save to file
			fasta_array = uploaded_io.read.scan(/>[^>]*/)

			if fasta_array.length == 0 
				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)

				# save_result_to_db(@uploading_result,fasta_array)

				render json: { "result": @uploading_result, "fasta": fasta_array }
			end

		elsif params[:sequence].present? == false and params[:authenticity_token].present? == true

			render json: { "notice": "Please enter sequence." }

			
		end


	end

	# add the correct sequence to database
	# and construct new blast database by makeblastdb
	def save_sequence_to_db
		puts params.inspect
		# Parameters: {"FirstName"=>"xuan", "Email"=>"cao", "authenticity_token"=>"xma4WROg4X5wBTnb0sORg+yEBsAKdAtdAO7reDOnexOjIwTpNsfg5vAictLHoF/NtNeVQbt8cnjPREyYJxRwsg=="}
		# render json: { "success": "yes!"}
		uploader_name = params[:name]
		uploader_email = params[:email]
		result = params[:table]
		sequence = params[:sequence]


		uploading_reuslt = JSON.parse(result)
		fasta_array = JSON.parse(sequence)

		# need to figure out how to pass uploading_result,fasta_array to save_sequence_to_db
		# get fasta_array from file (since you are storing the uploaded file to server anyway)
		# for the uploading_result; get from the table (id: upload-seq-result-table);
		# invoke this function by ajax (with form id:save-seqeunce)
		# how to give the file path? send the file path through ajax; and render it at page but hide it.


		# parameter passed
		status = save_result_to_db(uploading_result,fasta_array, uploader_name, uploader_email)

		if status == true
			render json: { "status": "Successfully saved to our database"}
		elsif status == false
			render json: { "status": "Sorry, something went wrong. Please notify developer; meanwhile, you can send your sequence to our lab."}
		end



	end



	# This is for sending to lab member emails
	def submit_sequence_lab
		puts params.inspect
		if params[:sequence].present?
			# puts "params[:sequence] => #{params[:sequence]}"
			fasta_array = params[:sequence].scan(/>[^>]*/)
			if fasta_array.length == 0 

				render json: { "notice": "Please enter sequence." }

			else
				sequence = ""
				fasta_array.each do |fasta_sequence|
					query = Bio::FastaFormat.new( fasta_sequence )
					sequence += "<p>>#{query.definition}</p><br><p>#{query.to_seq.seq}</p><br>"
				end

				send_sequence_to_lab_without_validation(sequence,params[:name],params[:email],params[:institution],params[:publications],params[:organism])
			
			end

		elsif !params[:fasta].nil?
			# make sure that once upload the file, user can't insert any sequence
			uploaded_io = params[:fasta]
			puts uploaded_io
			now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
			file_name = uploaded_io.original_filename.gsub(".fasta","#{now}.fasta")
			file_path = Rails.root.join('public', 'uploads/', file_name)
			# puts uploaded_io.read contains the content of file; no need to save to file

			fasta_array = uploaded_io.read.scan(/>[^>]*/)

			if fasta_array.length == 0 
				render json: { "notice": "Please enter sequence." }
			else
				sequence = ""
				fasta_array.each do |fasta_sequence|
					query = Bio::FastaFormat.new( fasta_sequence )
					sequence += "<p>>#{query.definition}</p><br><p>#{query.to_seq.seq}</p><br>"
				end


				send_sequence_to_lab_without_validation(sequence,params[:name],params[:email],params[:institution],params[:publications],params[:organism])

			end

		elsif params[:sequence].present? == false and params[:authenticity_token].present? == true

			render json: { "notice": "Please enter sequence." }

			
		end

		
		


	end



 
 # # implement the decision tree
 # def submit_sequence
 #   puts "params.inspect => #{params.inspect}"

 #   raw_sequence = params[:sequence]
 #   if raw_sequence == "undefined"
 #     raw_sequence = params[:form_sequence]
 #   end
 #   fasta_array = raw_sequence.scan(/>[^>]*/)

 #   query_name = nil
 #   sequence = nil
 #   if fasta_array.length > 1
 #     @query = Bio::FastaFormat.new( fasta_array[0] )
 #     query_name = @query.definition
 #     sequence = @query.to_seq
 #   end

 #   begin
 #     # organism should be similar, otherwise it won't get to this step
 #     new_sequence_info = SequenceInfo.new
 #     new_sequence_info.organism = params[:organism] || nil
 #     new_sequence_info.reference = params[:publications] || nil
 #     new_sequence_info.type = "Enzyme"
 #     new_customized_protein_sequences = CustomizedProteinSequence.new
 #     new_customized_protein_sequences.header = query_name
 #     new_customized_protein_sequences.chain  = sequence
 #     new_customized_protein_sequences.key_group = "NCBI Accession"
 #     new_customized_protein_sequences.key = params[:ncbi_accession_number]
 #     new_customized_protein_sequences.reference = params[:publications] || nil
 #     new_customized_protein_sequences.organism  = params[:organism] || nil
   
 #   rescue Exception => e 
 #     render json: {"message_err": e.message }

 #   end
   
 # end






end
