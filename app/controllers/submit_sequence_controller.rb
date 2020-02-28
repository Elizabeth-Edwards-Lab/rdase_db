class SubmitSequenceController < ApplicationController
	include QueryLogic
	include SequenceSubmitter
	# skip_before_action :verify_authenticity_token #if you skip before action, you will likely cause security violation

	# Use ajax strategy for clean page design
	def submit
		# puts params.inspect


		if params[:authenticity_token].present?
			# puts "here"
			# submit hit
			submission_result = validation_submission(params)
			puts submission_result 
			# puts submission_result.class 
			# Test passed... Need more test

			if submission_result.class == Hash
				# submit_sequence_caller_for_aa_nt will save success and new to database automatically
				# uploading_result is for showing the status for user
				uploading_result = submit_sequence_caller_for_aa_nt(submission_result["aa"],submission_result["nt"], params[:uploader_name],params[:uploader_email])

				render json: { "result": uploading_result }

			elsif submission_result.class == Array
				# there are errors
				render json: { "errors": submission_result }
			end
		
		end

	end

end
