class CustomizedNucleotideSequence < ApplicationRecord
	
	UPLOADER_TYPES = ['RDDB','USER']
	
	validates :chain, format: { with: /\A[ACTGN]+\z/ }, presence: false

	validates_inclusion_of :uploader, 
    	in: UPLOADER_TYPES, 
    	message: 'can only be RDDB, USER', 
    	allow_blank: false


end
