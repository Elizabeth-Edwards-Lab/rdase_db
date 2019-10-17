class CompoundController < ApplicationController

  helper CompoundHelper
	def index
		if params[:commit].present?
  		if params[:name].present? && !params[:header].present? && !params[:group].present? && !params[:organism].present?
  			@compound = Compound.where("name like ? ", "%#{params[:name]}%").limit(25).page(params[:page])
  		else
  			@compound = Compound.limit(15).page(params[:page])
  		end

  	else
  		@compound = Compound.limit(15).page(params[:page])
  	end

	end

	def show
		@compound = Compound.find(params[:id])
    # @synonyms = CompoundSynonym.find(params[:id])
    @protein = Array.new
    associated_protein = CompoundStrainRel.where(:compound_id => params[:id])
    associated_protein.each do |pro|
      @protein << CustomizedProteinSequence.find(pro.protein_id)
    end
	end
end
