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

	# def get_characterized_member(group)
	# 	final_characterized_member = ""
	# 	all_characterized_strain_id = CompoundStrainRel.all.select('protein_id').map(&:protein_id).uniq
	# 	group_members = CustomizedProteinSequence.where(:group => group)
	# 	group_members.each do |group_m|
	# 		if all_characterized_strain_id.include? group_m.id
	# 			final_characterized_member += "<a href='http://reductivedehalogenasedb.ca/protein/#{group_m.id}', target='_blank'> #{group_m.header}</a>|"
	# 		end
	# 	end
	# 	return final_characterized_member.html_safe
	# end

	# # be careful about _s at end of this function
	# def get_characterized_member_s(group)
	# 	if group.length == 1
	# 		return get_characterized_member(group)
	# 	else
	# 		multiple = ""
	# 		group.each do |g|
	# 			multiple += get_characterized_member(group)
	# 		end
	# 		return multiple
	# 	end
	# end

	def get_characterized_member(group)
		final_characterized_member = Array.new
		all_characterized_strain_id = CompoundStrainRel.all.select('protein_id').map(&:protein_id).uniq
		group_members = CustomizedProteinSequence.where(:group => group)
		group_members.each do |group_m|
			if all_characterized_strain_id.include? group_m.id
				final_characterized_member << [group_m.id, group_m.header]
			end
		end
		return final_characterized_member
	end

	# be careful about _s at end of this function
	def get_characterized_member_s(group)
		if group.length == 1
			return get_characterized_member
		else
			multiple = Array.new
			group.each do |g|
				tmp = get_characterized_member(group)
				multiple.push(*tmp) 
			end
			return multiple
		end
	end

end
