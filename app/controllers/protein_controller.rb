class ProteinController < ApplicationController


	
	def index
    @proteins = Protein.exported.
      order("#{@sorted_column} #{@sorted_order}").
      includes(:exported_metabolites).
      page(params[:page])
  end

  def show
    load_protein_objects!

    if @revocation.present?
      respond_to do |format|
        format.html { render action: 'revoked' }
        format.xml { render xml: @revocation, status: 404 }
        format.any { raise ActiveRecord::RecordNotFound }
      end
      return
    end
  end
end
