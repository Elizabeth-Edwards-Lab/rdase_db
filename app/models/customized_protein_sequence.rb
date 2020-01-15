class CustomizedProteinSequence < ApplicationRecord

	UPLOADER_TYPES = ['RDDB','USER']

	# has_one/has_many/belong_to enable ActiveRecord.joins() operations
	# has_many pair with belongs_to; to join based on one specific field, use foreign_key on both models
	# has_many/belongs_to are too difficult to use; use raw sql
	# has_many :customized_nucleotide_sequences, :foreign_key => :protein_id

	validates :chain, format: { with: /\A[*GAVLIMFWPSTCYNQDEKRHXBZUOJ]+\z/ } # accept wild * in sequence 
	before_validation :convert_to_short_form
	validates_inclusion_of :uploader, 
    	in: UPLOADER_TYPES, 
    	message: 'can only be RDDB, USER', 
    	allow_blank: false

	protected

	def convert_to_short_form
	  amino_acid_dictionary = { 'Ala' => 'A', 'Arg' => 'R', 'Asn' => 'N', 'Asp' => 'D', 'Cys' => 'C', 'Glu' => 'E', 
	                            'Gln' => 'Q', 'Gly' => 'G', 'His' => 'H', 'Ile' => 'I', 'Leu' => 'L', 'Lys' => 'K', 
	                            'Met' => 'M', 'Phe' => 'F', 'Pro' => 'P', 'Ser' => 'S', 'Thr' => 'T', 'Trp' => 'W', 
	                            'Tyr' => 'Y', 'Val' => 'V' }
	  amino_acid_dictionary.each_pair do |long_form, short_form|
	    self.chain.gsub!(/#{long_form}/, short_form) if self.chain.present?
	  end
	end
end
