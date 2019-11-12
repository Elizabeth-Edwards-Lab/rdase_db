module TreeBuilder
  extend ActiveSupport::Concern




  def turn_string_to_array(s)
  	s_array = s.gsub(/\[/, "").gsub(/\]/, "").tr('"', "").split(",")
  end


  
  def construct_in_clause_conditon(array, field)

  	final_conditon = "customized_protein_sequences.#{field} IN ("
  	array[0..(array.length - 1)].each do |g|
  		final_conditon += "'#{g}',"
  	end
  	final_conditon[final_conditon.length - 1] = ")"

  	return final_conditon
  end

  def construct_record(all_sequence, all_sequence_non)

  	if !all_sequence_non.nil? and !all_sequence.nil?
  		all_sequence = all_sequence.or(all_sequence_non)
  	elsif !all_sequence_non.nil? and all_sequence.nil? # only No Group selected
  		all_sequence = all_sequence_non
  	elsif all_sequence_non.nil? and all_sequence.nil? # not likely happen but put here anyway
  		all_sequence = CustomizedProteinSequence.where("1=0")
  	end

  	return all_sequence

  end

  # param: rails param
  # return: array of CustomizedProteinSequence object
  def extract_sequence_for_tree(params)
  	# puts params[:groups].class
  	# puts params[:organisms].class

  	# this is very ugly way to do the query, but this is the current approaches

  	groups = turn_string_to_array(params[:groups])
  	puts "groups => #{groups.inspect}"
  	organisms = turn_string_to_array(params[:organisms])
  	puts "organisms => #{organisms.inspect}"

  	if groups.include? "All OGs" and organisms.include? "All Organism"
  		# everything
  		puts "groups.include All OGs and organisms.include All Organism"
  		all_sequence = CustomizedProteinSequence.all

  		return all_sequence

  	elsif !groups.include? "All OGs" and organisms.include? "All Organism"
  		puts "groups don't include All OGs and organisms.include All Organism"
  		# every organisms
  		# check for Non group
  		all_sequence_non_group = nil
  		if groups.include? "No Group"
  			groups.delete("No Group")
  			all_sequence_non_group = CustomizedProteinSequence.where(:group => nil)
  		end
  		# puts "all_sequence_non_group => #{all_sequence_non_group.length}"

  		all_sequence = nil
  		if groups.length > 0
  			final_groups = construct_in_clause_conditon(groups,"group")
  			all_sequence = CustomizedProteinSequence.where(final_groups)
  		end
  		
  		all_sequence = construct_record(all_sequence,all_sequence_non_group)

  		return all_sequence


  	elsif groups.include? "All OGs" and !organisms.include? "All Organism"
  		puts "groups include All OGs and organisms don't include All Organism"
  		# all group 
  		# check for non ogranism
  		all_sequence_non_organism = nil
  		if organisms.include? "No Organism"
  			organisms.delete("No Organism")
  			all_sequence_non_organism = CustomizedProteinSequence.where(:organism => nil)
  		end

  		all_sequence = nil
  		if organisms.length > 0
  			final_organisms = construct_in_clause_conditon(organisms,"organism")
  			all_sequence = CustomizedProteinSequence.where(final_organisms)
  		end

  		all_sequence = construct_record(all_sequence,all_sequence_non_organism)

  		return all_sequence

  	elsif !groups.include? "All OGs" and !organisms.include? "All Organism"
  		# puts "groups don't include All OGs and organisms don't include All Organism"
  		# select either group or nil group and organism or nil organism
  		# groups has already removed the non groups (null)
  		# since the organisms that select has to contain the groups, so select group first, then select organism
  		
  		# select desired group first
  		all_sequence_non_group = nil
  		if groups.include? "No Group"
  			groups.delete("No Group")
  			all_sequence_non_group = CustomizedProteinSequence.where(:group => nil)
  		end
  		# puts "all_sequence_non_group => #{all_sequence_non_group.length}"

  		all_sequence = nil
  		if groups.length > 0
  			final_groups = construct_in_clause_conditon(groups,"group")
  			all_sequence = CustomizedProteinSequence.where(final_groups)
  		end
  		# puts "all_sequence_non_group => #{all_sequence.length}"

  		all_sequence = construct_record(all_sequence,all_sequence_non_group)
  		# end of select desired group first


  		# if organisms include no_organim, select the non_organism first
  		all_sequence_with_non_organism = nil
  		if organisms.include? "No Organism"
  			organisms.delete("No Organism")
  			all_sequence_with_non_organism = all_sequence.where(:organism => nil)
  		end

  		# if organisms include other organism, select them as well
  		all_sequence_with_organism = nil
  		if organisms.length > 0
  			final_organisms = construct_in_clause_conditon(organisms,"organism")
  			all_sequence_with_organism = all_sequence.where(final_organisms)
  			
  		end

  		all_sequence_with_organism = construct_record(all_sequence_with_non_organism,all_sequence_with_organism)

  		return all_sequence_with_organism

  	else

  		# return 0 record indicate something went to wrong
  		all_sequence = CustomizedProteinSequence.where("1=0")
  		
  		return all_sequence
  	end


  end


  # build_tree_data assume there are some sequence in current_time file
  def build_tree_data(current_time)
  	# the tree is based on AA (amino acid)
  	muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
  	if RUBY_PLATFORM == "x86_64-linux"
  	  muscle_path = "vendor/MUSCLE/muscle3.8.31_i86linux64"
  	else
  	  muscle_path = "vendor/MUSCLE/muscle3.8.31_i86darwin64"
  	end
    muscle = system( muscle_path,
                        "-in","tmp/tmp_fasta/fasta_#{current_time}.fasta",
                        "-out","tmp/tmp_fasta/#{current_time}.afa",
                        "-tree1", "tmp/tmp_fasta/#{current_time}.phy",
                        "-maxiters", "1",
                        "-diags","-sv",
                        "-distance1","kbit20_3","-quiet")

    # muscle may not finished, then render
    while muscle.nil?
      next
    end

    phy = File.open("tmp/tmp_fasta/#{current_time}.phy","r")

    tree_data = ""
    phy.each do |line|
      tree_data = tree_data + line.gsub("\n","")
    end
    phy.close()

    return tree_data


  end


  def construct_tree_data(sequence, params)
  	
  	fasta_array  = raw_sequence.scan(/>[^>]*/)
    sequence_def = Bio::FastaFormat.new( fasta_array[0] )
    aa_sequence  = sequence_def.to_seq.seq
    all_sequence = extract_sequence_for_tree(params)  # get desired sequence based on user options

    return all_sequence
    
  end

end






















