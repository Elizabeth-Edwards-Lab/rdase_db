class CustomizedNucleotideSequence < ApplicationRecord
	validates :chain, format: { with: /\A[ACTGN]+\z/ }
	UPLOADER_TYPES = ['RDDB','USER'] 


	validates_inclusion_of :uploader, 
    	in: UPLOADER_TYPES, 
    	message: 'can only be RDDB, USER', 
    	allow_blank: false
end
