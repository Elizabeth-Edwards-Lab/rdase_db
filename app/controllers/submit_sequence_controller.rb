class SubmitSequenceController < ApplicationController

	include SequenceSubmitter
	# skip_before_action :verify_authenticity_token #if you skip before action, you will likely cause security violation


	# Use ajax strategy for clean page design
	def submit
		# puts params.inspect
		puts "submit params => #{params.inspect}"
		fasta_array = Array.new

		# this submit require storing the sequence for actually save to database
		if params[:aa_sequence].present?
			# puts "params[:sequence] => #{params[:sequence]}"
			fasta_array = params[:sequence].scan(/>[^>]*/)
			if fasta_array.length == 0

				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)

				render json: { "result": @uploading_result, "fasta": fasta_array }

			end

		elsif !params[:fasta].nil?

			now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
			file_name = params[:fasta].original_filename.gsub(".fasta","#{now}.fasta")
			file_path = Rails.root.join('tmp', 'uploads/', file_name)
			file_content = params[:fasta].tempfile.read
			File.write(file_path,file_content)



			fasta_array = file_content.scan(/>[^>]*/)
			if fasta_array.length == 0 
				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)


				render json: { "result": @uploading_result, "fasta": fasta_array, "file_name": file_name }
			end

		elsif params[:sequence].present? == false and params[:authenticity_token].present? == true

			render json: { "notice": "Please enter sequence." }

			
		end


	end

	# add the correct sequence to database
	# and construct new blast database by makeblastdb
	def save_sequence_to_db
		uploader_name = params[:name]
		uploader_email = params[:email]
		uploading_result = JSON.parse(params[:table])
		file_name = params[:file_name]
		fasta_array = JSON.parse(params[:sequence])
		
		if file_name.nil?
			# save_result_to_db(result_array,fasta_array,uploader_name,uploader_email,organism,reference)
			status = save_result_to_db(uploading_result,fasta_array, uploader_name, uploader_email)
		else
			file_path = Rails.root.join('tmp', 'uploads/', file_name)
			fasta_array = File.open(file_path).read.scan(/>[^>]*/)
			status = save_result_to_db(uploading_result,fasta_array, uploader_name, uploader_email)
		end

		if status == true
			render json: { "status": "Successfully saved to our database"}
		elsif status == false
			render json: { "status": "Sorry, something went wrong. Please notify developer; meanwhile, you can send your sequence to our lab."}
		end



	end



	# This is for sending to lab member emails
	def submit_sequence_lab

		# transformed_param = JSON.parse(params)
		# puts transformed_param
		if params[:sequence].present?

			fasta_array = params[:sequence].scan(/>[^>]*/)
			if fasta_array.length == 0 

				render json: { "notice": "Please enter sequence." }

			else
				sequence = ""
				fasta_array.each do |fasta_sequence|
					query = Bio::FastaFormat.new( fasta_sequence )
					sequence += "<p>>#{query.definition}</p><br><p>#{query.to_seq.seq}</p><br>"
				end

				send_sequence_to_lab_without_validation(sequence,params[:name],params[:email],params[:institution],params[:publications],params[:organism],params[:comment])
			
			end
			
			render json: { "notice": "Submit successfully." }

		elsif !params[:fasta].nil?

			fasta_array = params[:fasta].tempfile.read.scan(/>[^>]*/)

			if fasta_array.length == 0 
				render json: { "notice": "Please enter sequence." }
			else
				sequence = ""
				fasta_array.each do |fasta_sequence|
					query = Bio::FastaFormat.new( fasta_sequence )
					sequence += "<p>>#{query.definition}</p><br><p>#{query.to_seq.seq}</p><br>"
				end
				
				send_sequence_to_lab_without_validation(sequence,params[:name],params[:email],params[:institution],params[:publications],params[:organism],params[:comment])

			end
			render json: { "notice": "Submit successfully." }

		elsif params[:sequence].present? == false and params[:authenticity_token].present? == true

			render json: { "notice": "Please enter sequence." }

			
		end

	end


end
