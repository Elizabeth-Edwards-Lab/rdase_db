namespace :update_characterized_info do


	# rake update_characterized_info:updates
	# bundle exec rake update_characterized_info:updates RAILS_ENV=production
	task :updates => [:environment] do
		compound_strain_rel = CompoundStrainRel.all
		characterized_protein_id = Array.new
		compound_strain_rel.each do |csr|
			if characterized_protein_id.include? csr.protein_id
				next
			else
				characterized_protein_id << csr.protein_id
			end
		end

		CustomizedProteinSequence.all.each do |protein|
			if characterized_protein_id.include? protein.id
				protein.characterized = 1
			else
				protein.characterized = 0
			end
			protein.save!
		end


  end

end