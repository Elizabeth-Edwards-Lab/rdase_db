require 'csv'
require 'zip'
class ProteinController < ApplicationController
  # SortParamsParser is for sort_table_link
  include SortParamsParser
  include QueryLogic

  def download_filtered_result_fasta
    accession = params[:accession_no]
    header    = params[:header]
    group     = params[:group]
    organism  = params[:organism]
    # params.inspect => <ActionController::Parameters {"accession"=>"", "group"=>"", "header"=>"RS01800", "organism"=>"", "controller"=>"protein", "action"=>"download_filtered_result"} permitted: false>
    if !accession.present? and !header.present? and !group.present? and !organism.present?
      # no filter certiera given, sort by default (which is sort by group)
      @protein = CustomizedProteinSequence.all
      
    elsif accession.present? or header.present? or group.present? or organism.present?
      # filter certiera is given
      @protein = protein_index_just_filter(params,nil,true)

    end

    zip_file = package_fasta_for_filtered_result(@protein)
    send_file zip_file, :type => "application/zip", :filename =>  zip_file
  end


  def download_filtered_result
    accession = params[:accession_no]
    header    = params[:header]
    group     = params[:group]
    organism  = params[:organism]
    export_file_name = "tmp/filtered_result/filtered_result.csv" # user will see the name
    # params.inspect => <ActionController::Parameters {"accession"=>"", "group"=>"", "header"=>"RS01800", "organism"=>"", "controller"=>"protein", "action"=>"download_filtered_result"} permitted: false>
    if !accession.present? and !header.present? and !group.present? and !organism.present?
      # no filter certiera given, sort by default (which is sort by group)
      @protein = CustomizedProteinSequence.all
      
    elsif accession.present? or header.present? or group.present? or organism.present?
      # filter certiera is given
      @protein = protein_index_just_filter(params,nil,true)

    end

    filename = package_csv_for_filtered_result(@protein)
    send_file filename, :type => "application/csv", :filename =>  export_file_name
  end
	
  def index
  	# puts "params.inspect => #{params.inspect}"
    # after add search feature
    # Parameters {"utf8"=>"✓", "commit"=>"Filter", "header"=>"", "group"=>"sdf", "organism"=>"", "update"=>"", "controller"=>"protein", "action"=>"index"}
    # after add sorting feature 
    # params.inspect => <ActionController::Parameters {"c"=>"group", "commit"=>"Filter", "d"=>"up", "group"=>"", "header"=>"", "organism"=>"", "utf8"=>"✓", "controller"=>"protein", "action"=>"index"} permitted: false>
    
    # group => filter
    # no group info anymore, but I think that's fine, user want to see that particular name anyway
    # Parameters: {"utf8"=>"✓", "commit"=>"Filter", "accession"=>"", "header"=>"1395", "group"=>"", "organism"=>""}
    # if just click filter, no sorting params
    # if just click sort first time, not filter params
    # if just click sort after first time, both filter and sorting params
 

  	if params[:commit] == "Filter"
      accession = params[:accession_no]
      header    = params[:header]
      group     = params[:group]
      organism  = params[:organism]
      if params[:c].nil? and params[:d].nil?
        puts "just filtering"
        # user didn't click the sort link, just simple filter
        # first header will be accession
        # protein = CustomizedProteinSequence.where("header like ? AND header like ? AND customized_protein_sequences.group like ? AND organism like ?", 
        if !accession.present? and !header.present? and !group.present? and !organism.present?
          # no filter certiera given, sort by default (which is sort by group)
          @protein = CustomizedProteinSequence.order(group: :ASC).limit(25).page(params[:page])
          
        elsif accession.present? or header.present? or group.present? or organism.present?
          # filter certiera is given
          @protein = protein_index_just_filter(params)

        end

      else # if there is params[:c] and params[:d]
        # do filter and then sorting
        # if just sorting without filter at first, there is no params[:commit] 
        puts "filtering => sorting"
        sort_order = nil
        if params[:d] == "up"
          sort_order = "asc"
        else
          sort_order = "desc"
        end

        if !accession.present? and !header.present? and !group.present? and !organism.present?
          # no filter certiera given, sort by default (which is sort by group)
          @protein = CustomizedProteinSequence.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
          
        elsif accession.present? or header.present? or group.present? or organism.present?

          @protein = protein_index_just_filter(params, true)

        end

      end

    elsif !params[:commit].nil? and params[:commit] != "Filter"
      # commit appears but it is for grouping
      puts "just grouping"
      @protein = CustomizedProteinSequence.where(:group => params[:group]).limit(25).page(params[:page])
    else #if params[:commit].nil
      # first page when enter sequence page
      # afte set non-group to 0, set :DESC to :ASC
      puts "just sorting"

      if params[:c].nil? and params[:d].nil?
        # first enter the sequence page => default sort by group
        # @protein = CustomizedProteinSequence.order(group: not :nil ,group: :ASC).limit(25).page(params[:page])
        # https://stackoverflow.com/questions/5826210/rails-order-with-nulls-last
        @protein = CustomizedProteinSequence.order("customized_protein_sequences.group is NULL, customized_protein_sequences.group ASC").limit(25).page(params[:page])
      else
        # user did sorting without filter at first
        sort_order = nil
        if params[:d] == "up"
          sort_order = "asc"
        else
          sort_order = "desc"
        end

        if params[:commit].nil?

          @protein = CustomizedProteinSequence.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])

        end
      end
    end
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
