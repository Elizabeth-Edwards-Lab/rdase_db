class ProteinController < ApplicationController


	
  def index
  	puts params.inspect
  	# Parameters {"utf8"=>"✓", "commit"=>"Filter", "header"=>"", "group"=>"sdf", "organism"=>"", "update"=>"", "controller"=>"protein", "action"=>"index"}
  	if params[:commit].present?
  		if params[:update].present? && !params[:header].present? && !params[:group].present? && !params[:organism].present?
  			# if update date present, there is no something like "like"
  			@protein = CustomizedProteinSequence.where("update_date >= ?", params[:update]).limit(25).page(params[:page])
  		elsif !params[:update].present? && params[:header].present? && !params[:group].present? && !params[:organism].present?
				@protein = CustomizedProteinSequence.where("header like ?", "%#{params[:header]}%").limit(25).page(params[:page])
  		elsif !params[:update].present? && !params[:header].present? && params[:group].present? && !params[:organism].present?
				@protein = CustomizedProteinSequence.where(:group => params[:group]).limit(25).page(params[:page])
  		elsif !params[:update].present? && !params[:header].present? && !params[:group].present? && params[:organism].present?
  			@protein = CustomizedProteinSequence.where("organism like ? ", "%#{params[:organism]}%").limit(25).page(params[:page])
  		elsif params[:update].present? || params[:header].present? || params[:group].present? || params[:organism].present?
  			if !params[:update].present?
  				@protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
  					"%#{params[:header]}%", "%#{params[:organism]}%", params[:group], "1000-01-01").limit(25).page(params[:page])
  			else
  				@protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
  					"%#{params[:header]}%", "%#{params[:organism]}%", params[:group], params[:update]).limit(25).page(params[:page])

  			end
  			
  		else
  			@protein = CustomizedProteinSequence.limit(25).page(params[:page])
  		end

  	else
  		@protein = CustomizedProteinSequence.limit(25).page(params[:page])
  	end
  	# protein = CustomizedProteinSequence.where(:header => "8657036VS")
  	# puts "protein.class => #{protein.class}"
    
    # puts "protein.class => #{@protein.class}"
  end

  def show
    # puts params.inspect
    @protein_s = CustomizedProteinSequence.find(params[:id])
  end
end
