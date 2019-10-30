module ProteinHelper


	def contain_compound(protein_id)
		rel = CompoundStrainRel.where(:protein_id => protein_id)
		if rel.length > 0
			return true
		else
			return false
		end
	end


	def style_chain(chain)
		after_style = ""
		length_per_line = 60 # 60 char then \n
		space_per_line = 10 # 10 char then space
		# {line number}<span></span>
		after_style += "1 <span>"
		(1..chain.length).step(1) do |n|
			
			if n%space_per_line == 0
				after_style += " "
			end

			if n%length_per_line == 0
				# new line
				after_style +=  "</span><br>#{n+1} <span>"
			end
			after_style += chain[n-1]
		end

		after_style += "</span>"

		# convert string to html element
		return after_style.html_safe
	end


end
