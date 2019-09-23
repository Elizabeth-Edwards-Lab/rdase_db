class CustomizedProteinSequence < ApplicationRecord
	validates :chain, format: { with: /\A[GAVLIMFWPSTCYNQDEKRHXBZUOJ]+\z/ }
	UPLOADER_TYPES = ['RDDB','USER'] 
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
