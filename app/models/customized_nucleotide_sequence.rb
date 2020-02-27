class CustomizedNucleotideSequence < ApplicationRecord
	
	UPLOADER_TYPES = ['RDaseDB', 'Public']
	belongs_to :customized_protein_sequence, :foreign_key => "protein_id"
	
	validates_inclusion_of :uploader, 
    	in: UPLOADER_TYPES, 
    	message: 'can only be RDaseDB or Public', 
    	allow_blank: false
end
