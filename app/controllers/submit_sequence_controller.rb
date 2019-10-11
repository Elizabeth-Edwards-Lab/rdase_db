class SubmitSequenceController < ApplicationController

	include SequenceSubmitter



	# Use ajax strategy for clean page design
	def submit
		# puts params.inspect

		fasta_array = Array.new
		puts params[:sequence].present?
		if params[:sequence].present?
			# puts "params[:sequence] => #{params[:sequence]}"
			fasta_array = params[:sequence].scan(/>[^>]*/)
			puts "fasta_array => #{fasta_array} => #{fasta_array.length}"
			if fasta_array.length == 0 

				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)
				render json: { "result": @uploading_result }

			end

		elsif !params[:fasta].nil?
			# make sure that once upload the file, user can't insert any sequence
			uploaded_io = params[:fasta]
			now = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
			file_name = uploaded_io.original_filename.gsub(".fasta","#{now}.fasta")
			file_path = Rails.root.join('public', 'uploads/', file_name)
			# puts uploaded_io.read contains the content of file; no need to save to file
			fasta_array = uploaded_io.read.scan(/>[^>]*/)

			if fasta_array.length == 0 
				render json: { "notice": "Please enter sequence." }
			elsif fasta_array.length > 20
				render json: { "notice": "Please enter less than 20 sequence for once." }
			else
				@uploading_result = submit_sequence_caller(fasta_array)
				render json: { "result": @uploading_result }
			end
		elsif params[:sequence].present? == false and params[:authenticity_token].present? == true

			render json: { "notice": "Please enter sequence." }
			
		end

		

		


	end

end
