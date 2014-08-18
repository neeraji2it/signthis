class PurchaseController < ApplicationController
  respond_to :html

  def create
    @document = Document.joins(:link).where(links: {key: params[:key]}).readonly(false).first.decorate
    @purchase = Purchase.new purchase_params
    service = DocumentPaymentService.new @document, @purchase
    if service.create
      redirect_to public_documents_url(key: @document.public_key)
    else
      flash[:alert] = "There was a problem with payment"
      render template: 'documents/show'
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:cardholder_first_name, :cardholder_last_name, :card_number, :expiration_date_month, :expiration_date_year, :card_code, :stripe_card_token)
  end
end
