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
end
