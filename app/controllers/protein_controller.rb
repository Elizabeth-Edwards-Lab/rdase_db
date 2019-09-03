require 'csv'
class ProteinController < ApplicationController




  def download_filtered_result


    
    
    now = Time.now.strftime("%Y_%m_%d_%H_%M")
    filename = "tmp/filtered_result/filtered_#{now}.csv"
    export_file_name = "tmp/filtered_result/filtered_#{now}.csv" # user will see the name
    if params[:update].present? && !params[:header].present? && !params[:group].present? && !params[:organism].present?
      # if update date present, there is no something like "like"
      @protein = CustomizedProteinSequence.where("update_date >= ?", params[:update]).limit(25).page(params[:page])
      export_file_name = "tmp/filtered_result/filtered_#{params[:update]}.csv"
    elsif !params[:update].present? && params[:header].present? && !params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where("header like ?", "%#{params[:header]}%").limit(25).page(params[:page])
      export_file_name = "tmp/filtered_result/filtered_#{params[:header]}.csv"
    elsif !params[:update].present? && !params[:header].present? && params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where(:group => params[:group]).limit(25).page(params[:page])
      export_file_name = "tmp/filtered_result/filtered_#{params[:group]}.csv"
    elsif !params[:update].present? && !params[:header].present? && !params[:group].present? && params[:organism].present?
      @protein = CustomizedProteinSequence.where("organism like ? ", "%#{params[:organism]}%").limit(25).page(params[:page])
      export_file_name = "tmp/filtered_result/filtered_#{params[:organism]}.csv"
    elsif params[:update].present? || params[:header].present? || params[:group].present? || params[:organism].present?
      if !params[:update].present?
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], "1000-01-01").limit(25).page(params[:page])
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}}.csv"
      else
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], params[:update]).limit(25).page(params[:page])
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}_#{params[:update]}}.csv"
      end
    else
      @protein = CustomizedProteinSequence.limit(25).page(params[:page])
    end



    # export the filtered result into csv
    CSV.open(filename, "w") do |csv|
      csv << ["header","amino acid sequence","nucleotide sequence","group","organism","publish_date"]
      @protein.each do |p|
        nt_object = CustomizedNucleotideSequence.find_by(:header => p.header)
        nt_sequence = ""
        if !nt_object.nil?
          nt_sequence = nt_object.chain
        end
        csv << [p.header,p.chain,nt_sequence,p.group,p.organism,p.update_date]
      end
    end
    send_file filename, :type => "application/csv", :filename =>  export_file_name
  end
	
  def index
  	# puts params.inspect
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
    @gene_s = CustomizedNucleotideSequence.find_by(:header => @protein_s.header)
    
  end
end
