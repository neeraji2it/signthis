class SignaturesController < ApplicationController
  before_action :set_signature

  def update
    respond_to do |format|
      if @signature.update!(signature_params)
        format.html { redirect_to @signature.document, notice: 'Document was successfully updated.' }
        format.js { render 'update_success' }
      else
        format.html { redirect_to @signature.document, alert: 'Document was not updated.' }
        format.js { render 'update_failure' }
      end
    end
  end

  private

  def set_signature
    @signature = Signature.find(params[:id])
  end

  def signature_params
    params.require(:signature).permit(:data)
  end
end
