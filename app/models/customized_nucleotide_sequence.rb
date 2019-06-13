class CustomizedNucleotideSequence < ApplicationRecord
	validates :chain, format: { with: /\A[ACTGN]+\z/ }
end
