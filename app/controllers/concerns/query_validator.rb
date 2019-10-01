module QueryValidator
	extend ActiveSupport::Concern

	# To test conern method in Rails console: 
	# Inside the Rails console
	# querycontroller = ActionController::Base::ApplicationController.new
	# querycontroller.extend(QueryValidator)
	# querycontroller.validate_amino_acid_sequnence()


	# Do validation for user input sequence
	# sequence = params[:sequence]
	def validate_amino_acid_sequnence(sequence)
		error_msg = Hash.new 
		if sequence.blank?

      error_msg["empty"] = "Please enter an amino acid sequence. Or try our example!"
    
    else
    	if sequence.length > 1000
    	
    		error_msg["length"] = "Your sequence is #{sequence.length} long. Please keep it within 2000 characters."
    	
    	else
	    	# "\n\n>sequence\n\nseq\n\n\n".strip => ">sequence\n\nseq"
	    	sequence_splited = sequence.strip.split(/\n/)

	    	if sequence_splited.length >= 2
	    		# possible standard fasta input
	    		header = sequence_splited[0]
	    		validate_sequence = sequence_splited[sequence_splited.length - 1]

	    		if !header.include? ">"
	    			header = ">#{header}"
	 				end

	    	elsif sequence_splited.length == 1 
	    		# possible only given header or just sequence
	    		if sequence_splited[0].include? ">"
	    			error_msg["empty"] = "Please enter an amino acid sequence. Or try our example!"
	    		else
	    			header = ">Submitted Sequence 1"
	    		end
	    	end

	    	# format ok; now test if the sequence is ok
	    	is_match = validate_sequence =~ /\A[*GAVLIMFWPSTCYNQDEKRHXBZUOJ]+\z/
	    	if is_match.nil?
	    		error_msg["wrong"] = "Your amino acid sequence is not validated. Please follow fasta format."
	    	end
    	end
    end
		
    # puts error_msg.inspect
		if error_msg.length > 0
			return error_msg
		elsif error_msg == 0
			return "#{header}\n#{validate_sequence}"
		end

	end


end