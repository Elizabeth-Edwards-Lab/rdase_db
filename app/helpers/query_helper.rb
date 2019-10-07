module QueryHelper

	def find_id_by_header(header)
		# puts "Header => #{header}"
		protein = CustomizedProteinSequence.find_by(:header => header)
		if !protein.nil?
			return protein.id
		else
			# what? why header will work... return nil will fail... what...
			return header
		end
	end

	def get_percentage_identity(identity, seq_length)
		return (identity.to_f / seq_length.to_f * 100).round(2)
	end
end
