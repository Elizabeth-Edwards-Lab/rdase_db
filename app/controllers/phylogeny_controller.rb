class PhylogenyController < ApplicationController

	include TreeBuilder

	def show
		# prepare the data for pre constructed tree
		# if there is no group and organism info, then just render default tree
		# if there is group and organism info, then extract info and render the json


		if params[:group].present? or params[:organism].present? or params[:groups].present? or params[:group].present?
			current_time = Time.now.strftime("%Y_%m_%d_%H_%M_%S_%L")
			all_sequence = extract_sequence_for_tree(params)
			
			if all_sequence.length == 0

				render json: { "num_sequence": all_sequence.length }
			else

				fasta_new  = File.open("#{Rails.root}/tmp/tmp_fasta/fasta_#{current_time}.fasta","w")
				
				data_group = Hash.new
				header_pool = Array.new
				all_sequence.each do |s|
				  data_group[s.header] = s.group
				  if header_pool.include? s.header
				    next
				  else
				    fasta_new << ">#{s.header}\n"
				    fasta_new << "#{s.chain}\n"
				    header_pool << s.header
				  end
				end
				fasta_new.close()
				tree_data = build_tree_data(current_time)
				
				render json: { "tree": tree_data, "group": data_group,
					"num_sequence": all_sequence.length }

			end
			
			
		end

		@phy_data = File.read("public/pre-constructed-tree.nwk")

		all_sequence = CustomizedProteinSequence.all
		@group_info = Hash.new
		all_sequence.each do |s|
			@group_info[s.header] = s.group
		end

		@last_update_date = CustomizedProteinSequence.order("created_at DESC").limit(1)[0].created_at

		@group_number_list = Array.new
		@organism_list = Array.new

		all_sequence.each do |single_entry|

		  if !@group_number_list.include? single_entry.group
		    @group_number_list << single_entry.group
		  end

		  if !@organism_list.include? single_entry.organism
		    @organism_list << single_entry.organism
		  end

		end





	end


end
