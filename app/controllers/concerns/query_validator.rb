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
	    	sequence = sequence.gsub(/\r/, '').gsub(/ /,'')
	    	begin
	    		query = Bio::FastaFormat.new( sequence )

	    		if query.to_seq.definition.empty?
	    			header = ">Submitted Sequence 1"
	    		else
	    			header = query.to_seq.definition
	    		end

	    		if query.to_seq.seq.empty?
	    			error_msg["empty"] = "Please enter an amino acid sequence. Or try our example!"
	    		else
	    			is_match = query.to_seq.seq =~ /\A[*GAVLIMFWPSTCYNQDEKRHXBZUOJ]+\z/
	    			if is_match.nil?
	    				error_msg["wrong"] = "Your amino acid sequence is not validated. Please follow fasta format with no space or any escape characters."
	    			end
	    			
	    		end

	    	rescue
	    		error_msg["wrong"] = "Your amino acid sequence is not validated. Please follow fasta format with no space or any escape characters."
	    	end
	    	

    	end
    end
		
    # puts error_msg.inspect
		if error_msg.length > 0
			return error_msg
		elsif error_msg == 0
			return ">#{header}\n#{query.to_seq.seq}"
		end

	end


end