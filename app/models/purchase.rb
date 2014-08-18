class Purchase
  include ActiveModel::Model

  attr_accessor :cardholder_first_name, :cardholder_last_name, :card_number, :expiration_date_month, :expiration_date_year, :card_code, :stripe_card_token, :charge

  def create(metadata={})
    self.charge = Stripe::Charge.create(
      amount: Document::DEFAULT_PRICE,
      currency: 'usd',
      card: stripe_card_token,
      description: "Payment for agreement",
      metadata: metadata
    )
  rescue Stripe::InvalidRequestError => e
    errors.add :base, "There was a problem with your credit card"
  end

  def valid?
    errors.empty?
  end

  def cardholder_name
    "#{cardholder_first_name} #{cardholder_last_name}"
  end
end
