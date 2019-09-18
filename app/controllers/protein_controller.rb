require 'csv'
require 'zip'
class ProteinController < ApplicationController
  # SortParamsParser is for sort_table_link
  include SortParamsParser

  def download_filtered_result_fasta

    now = Time.now.strftime("%Y_%m_%d_%H_%M_%S.%L")
    filename_protein = "tmp/filtered_result/filtered_#{now}_protein.fasta"
    filename_gene = "tmp/filtered_result/filtered_#{now}_gene.fasta"
    export_file_name = "tmp/filtered_result/filtered_#{now}.fasta" # user will see the name
    puts "params.inspect => #{params.inspect}"
    if params[:update].present? && !params[:header].present? && !params[:group].present? && !params[:organism].present?
      # if update date present, there is no something like "like"
      @protein = CustomizedProteinSequence.where("update_date >= ?", params[:update])
      export_file_name = "tmp/filtered_result/filtered_#{params[:update]}.fasta"
    elsif !params[:update].present? && params[:header].present? && !params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where("header like ?", "%#{params[:header]}%")
      export_file_name = "tmp/filtered_result/filtered_#{params[:header]}.fasta"
    elsif !params[:update].present? && !params[:header].present? && params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where(:group => params[:group])
      export_file_name = "tmp/filtered_result/filtered_#{params[:group]}.fasta"
    elsif !params[:update].present? && !params[:header].present? && !params[:group].present? && params[:organism].present?
      @protein = CustomizedProteinSequence.where("organism like ? ", "%#{params[:organism]}%")
      export_file_name = "tmp/filtered_result/filtered_#{params[:organism]}.fasta"
    elsif params[:update].present? || params[:header].present? || params[:group].present? || params[:organism].present?
      if !params[:update].present?
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], "1000-01-01")
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}}.fasta"
      else
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], params[:update])
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}_#{params[:update]}}.fasta"
      end
    else
      @protein = CustomizedProteinSequence.all
    end
    # export the filtered result into csv
    File.open(filename_protein, "w") do |f|
      @protein.each do |pt|
        f << ">" + pt.header + "\n"
        f << pt.chain + "\n"
      end
    end

    File.open(filename_gene, "w") do |f|
      @protein.each do |pt|
        gene = CustomizedNucleotideSequence.find_by(:header => pt.header)
        if !gene.nil?
          f << ">" + gene.header + "\n"
          f << gene.chain + "\n"
        end
      end
    end


    # zip_file = File.new("tmp/filtered_result/filtered_#{now}.zip", 'w')
    zip_file = "tmp/filtered_result/filtered_#{now}.zip"
    Zip::File.open(zip_file, Zip::File::CREATE) { |zipfile|
      zipfile.add("filtered_#{now}_protein.fasta","#{Rails.root}/#{filename_protein}")
      zipfile.add("filtered_#{now}_gene.fasta","#{Rails.root}/#{filename_gene}")
      # zipfile.get_output_stream("filtered")
    }

    send_file zip_file, :type => "application/zip", :filename =>  zip_file
  end


  def download_filtered_result

    now = Time.now.strftime("%Y_%m_%d_%H_%M")
    filename = "tmp/filtered_result/filtered_#{now}.csv"
    export_file_name = "tmp/filtered_result/filtered_#{now}.csv" # user will see the name
    puts "params.inspect => #{params.inspect}"
    if params[:update].present? && !params[:header].present? && !params[:group].present? && !params[:organism].present?
      # if update date present, there is no something like "like"
      @protein = CustomizedProteinSequence.where("update_date >= ?", params[:update])
      export_file_name = "tmp/filtered_result/filtered_#{params[:update]}.csv"
    elsif !params[:update].present? && params[:header].present? && !params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where("header like ?", "%#{params[:header]}%")
      export_file_name = "tmp/filtered_result/filtered_#{params[:header]}.csv"
    elsif !params[:update].present? && !params[:header].present? && params[:group].present? && !params[:organism].present?
      @protein = CustomizedProteinSequence.where(:group => params[:group])
      export_file_name = "tmp/filtered_result/filtered_#{params[:group]}.csv"
    elsif !params[:update].present? && !params[:header].present? && !params[:group].present? && params[:organism].present?
      @protein = CustomizedProteinSequence.where("organism like ? ", "%#{params[:organism]}%")
      export_file_name = "tmp/filtered_result/filtered_#{params[:organism]}.csv"
    elsif params[:update].present? || params[:header].present? || params[:group].present? || params[:organism].present?
      if !params[:update].present?
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], "1000-01-01")
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}}.csv"
      else
        @protein = CustomizedProteinSequence.where("header like ? AND organism like ? AND customized_protein_sequences.group = ? AND update_date >= ?", 
          "%#{params[:header]}%", "%#{params[:organism]}%", params[:group], params[:update])
        export_file_name = "tmp/filtered_result/filtered_#{params[:header]}_#{params[:organism]}_#{params[:group]}_#{params[:update]}}.csv"
      end
    else
      @protein = CustomizedProteinSequence.all
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
  	# puts "params.inspect => #{params.inspect}"
    # after add search feature
    # Parameters {"utf8"=>"✓", "commit"=>"Filter", "header"=>"", "group"=>"sdf", "organism"=>"", "update"=>"", "controller"=>"protein", "action"=>"index"}
    # after add sorting feature 
    # params.inspect => <ActionController::Parameters {"c"=>"group", "commit"=>"Filter", "d"=>"up", "group"=>"", "header"=>"", "organism"=>"", "utf8"=>"✓", "controller"=>"protein", "action"=>"index"} permitted: false>
    
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
    puts "params.inspect => #{params.inspect}"
    @protein_s = CustomizedProteinSequence.find(params[:id])
    @member = Array.new
    group_members = CustomizedProteinSequence.where(:group => @protein_s.group)

    group_members.each do |m|
      if m.header != @protein_s.header
        @member << m
      end
    end

    @gene_s = CustomizedNucleotideSequence.find_by(:header => @protein_s.header)
    
  end
end
