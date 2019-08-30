class Compound < ApplicationRecord




	before_validation :increment_public_id, on: :create


	

	private

  # Set the public ID to the next available ID based on the compound entries 
  # that already exist. This runs pre-validation, and only sets the public ID
  # if it hasn't been set explicitely.
  def increment_public_id
    if self.public_id.blank?
      self.public_id = Compound.exists? ? Compound.order(:public_id).last.public_id.next : 'RDDB00001'
    end
  end
end
