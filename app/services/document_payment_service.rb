class DocumentPaymentService

  attr_accessor :document, :purchase

  def initialize(document, purchase)
    @document, @purchase = document, purchase
  end

  def create
    @purchase.create metadata
    status = @purchase.valid?
    if status
      @document.update!({stripe_payment_id: @purchase.charge.id})
      NewPurchaseMailer.send_notification(@document.emails, @purchase.cardholder_name).deliver
    end
    status
  end

  private

  def metadata
    {
      agreement_id: @document.id,
      agreement_name: @document.filename
    }
  end
end
