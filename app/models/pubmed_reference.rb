class PubmedReference < ApplicationRecord
    default_scope { order(pubmed_id: :asc) }
    alias_attribute :name, :pubmed_id
    belongs_to :customized_protein_sequence, :foreign_key => 'strain_id'
end