class CompoundController < ApplicationController


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
	end
end
