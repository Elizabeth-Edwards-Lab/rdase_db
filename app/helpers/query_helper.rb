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

	def get_percentage_identity(hit)
		if hit.query_len > hit.query_seq.length
			match_identity = (hit.identity.to_f / hit.query_seq.length.to_f * 100).round(2)
		elsif hit.query_len < hit.query_seq.length
			match_identity = (hit.identity.to_f / hit.query_len.to_f * 100).round(2)
		end
		return match_identity
	end

end
