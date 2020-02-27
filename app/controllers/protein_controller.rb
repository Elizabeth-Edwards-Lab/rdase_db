require 'csv'
require 'zip'
class ProteinController < ApplicationController
  # SortParamsParser is for sort_table_link
  include SortParamsParser
  include QueryLogic
  include SeqSummarizer
  helper ProteinHelper

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

  	if params[:commit] == "Filter"
      accession = params[:accession_no]
      header    = params[:header]
      group     = params[:group]
      organism  = params[:organism]
      genbank_id = params[:genbank_id]
      protein_name = params[:protein_name]
      # puts "params[:genbank_id] => #{params[:genbank_id]}"
      if params[:c].nil? and params[:d].nil?

        if accession.present? or header.present? or group.present? or organism.present? or genbank_id.present? or protein_name.present?
          @protein = protein_index_just_filter(params)
        else
          @protein = CustomizedProteinSequence.order(group: :ASC).limit(25).page(params[:page])
        end

      else
        # do filter and then sorting; if just sorting without filter at first, there is no params[:commit] 
        sort_order = nil
        if params[:d] == "up"
          sort_order = "asc"
        else
          sort_order = "desc"
        end

        if !accession.present? and !header.present? and !group.present? and !organism.present? and !genbank_id.present? and !protein_name.present?
          # no filter certiera given, sort by default (which is sort by group); this invoke when filter first, then sort second
          if params[:c] != "genbank_id"
            protein_sorted = CustomizedProteinSequence.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
          else
            protein_sorted = CustomizedProteinSequence.joins("left join customized_nucleotide_sequences on customized_nucleotide_sequences.protein_id = customized_protein_sequences.id")
                            .order("customized_nucleotide_sequences.accession_no is NULL, customized_nucleotide_sequences.accession_no #{sort_order}").limit(25).page(params[:page])
          end
          @protein = protein_sorted
          # @protein = CustomizedProteinSequence.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
          
        elsif accession.present? or header.present? or group.present? or organism.present? or genbank_id.present? or protein_name.present?

          @protein = protein_index_just_filter(params, sort=true)

        end

      end

    elsif !params[:commit].nil? and params[:commit] != "Filter"
      # this is 
      @protein = CustomizedProteinSequence.where(:group => params[:group]).limit(25).page(params[:page])
    
    else

      if params[:c].nil? and params[:d].nil?
        # https://stackoverflow.com/questions/5826210/rails-order-with-nulls-last
        @protein = CustomizedProteinSequence.order("customized_protein_sequences.group is NULL, customized_protein_sequences.group ASC").limit(25).page(params[:page])
      else
        # user did sorting without filter at first

        sort_order = nil
        protein_sorted = nil

        if params[:d] == "up"
          sort_order = "asc"
        else
          sort_order = "desc"
        end

        if params[:commit].nil?
          if params[:c] != "genbank_id"
            protein_sorted = CustomizedProteinSequence.order("customized_protein_sequences.#{params[:c]} is NULL, customized_protein_sequences.#{params[:c]} #{sort_order}").limit(25).page(params[:page])
          else
            protein_sorted = CustomizedProteinSequence.joins("left join customized_nucleotide_sequences on customized_nucleotide_sequences.protein_id = customized_protein_sequences.id")
                            .order("customized_nucleotide_sequences.accession_no is NULL, customized_nucleotide_sequences.accession_no #{sort_order}").limit(25).page(params[:page])
          end
          @protein = protein_sorted
        end

      end
    end
    
  end




  def show
    @protein_s = CustomizedProteinSequence.find(params[:id])
    @member = Array.new
    group_members = CustomizedProteinSequence.where(:group => @protein_s.group)

    group_members.each do |m|
      if m.header != @protein_s.header
        @member << m
      end
    end

    @gene_s = CustomizedNucleotideSequence.find_by(:protein_id => @protein_s.id)

    @compound = Array.new
    associated_compound = CompoundStrainRel.where(:protein_id => @protein_s.id)
    associated_compound.each do |comp|
      @compound << Compound.find(comp.compound_id)
    end
    
    @reference = PubmedReference.where(:strain_id => @protein_s.id)
    @mw = calculateMolecularWeight(@protein_s.chain)
    
  end
end
































