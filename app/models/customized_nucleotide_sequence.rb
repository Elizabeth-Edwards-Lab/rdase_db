class CustomizedNucleotideSequence < ApplicationRecord
	
	UPLOADER_TYPES = ['RDDB','USER']
		
	# belongs_to :customized_protein_sequences, :foreign_key => :protein_id

	# validates :chain, format: { with: /\A[ACTGN]+\z/ }, presence: false


	validates_inclusion_of :uploader, 
    	in: UPLOADER_TYPES, 
    	message: 'can only be RDDB, USER', 
    	allow_blank: false


end
