class ProteinController < ApplicationController


	
  def index
    @protein = CustomizedProteinSequence.limit(25).page(params[:page])
  end

  def show
    # puts params.inspect
    @protein_s = CustomizedProteinSequence.find(params[:id])
  end
end
