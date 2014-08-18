require 'spec_helper'

describe Purchase do

  describe '#valid?' do
    it 'false if there are any errors' do
      purchase = Purchase.new
      purchase.errors.add :base, 'error1'
      expect(purchase).to_not be_valid
    end

    it 'true if there arent any erorrs' do
      expect(subject).to be_valid
    end
  end

  describe '#cardholder_name' do
    it 'combined from first and last name' do
      purchase = Purchase.new cardholder_first_name: 'TOM', cardholder_last_name: 'JERRY'
      expect(purchase.cardholder_name).to eq 'TOM JERRY'
    end
  end


  describe '#create' do
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'update charge for object' do
      purchase = Purchase.new stripe_card_token: 'xx1'
      purchase.create
      expect(purchase.charge.amount).to eq 50000
      expect(purchase.charge.currency).to eq 'usd'
      expect(purchase.charge.description).to eq 'Payment for agreement'
      expect(purchase.charge.paid).to be_true
    end

    it 'send metadata' do
      purchase = Purchase.new
      meta = {a: 1, b: 2}
      purchase.create meta
      expect(purchase.charge.metadata["a"]).to eq 1
      expect(purchase.charge.metadata["b"]).to eq 2
    end

    context 'after stripe request error' do
      let(:error) { Stripe::InvalidRequestError.new('request', 'error') }
      before { StripeMock.prepare_error error }

      it 'purchase is not valid' do
        purchase = Purchase.new
        purchase.create
        expect(purchase).to_not be_valid
      end
    end
  end
end
