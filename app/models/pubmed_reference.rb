class PubmedReference < ApplicationRecord
    belongs_to :customized_protein_sequence, :foreign_key => 'strain_id'
end
