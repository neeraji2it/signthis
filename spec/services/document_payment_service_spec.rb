require 'spec_helper'

describe DocumentPaymentService do
  let(:document) { build_stubbed :document }
  let(:purchase) { Purchase.new stripe_card_token: 'tkn123' }

  let(:service) { DocumentPaymentService.new document, purchase }

  describe '#create' do
    before do
      document.stub id: '1'
      document.stub filename: 'doc name'
      purchase.stub charge: double(id: 'stripe_id')
    end

    context 'without stripe errors' do
      before { expect(purchase).to receive(:create).with(agreement_id: '1', agreement_name: 'doc name').and_return(true) }

      it 'make document purchased' do
        expect(document.purchased?).to be_false
        service.create
        expect(document.purchased?).to be_true
        expect(document.stripe_payment_id).to eq 'stripe_id'
      end

      it 'send email' do
        service.create
        ActionMailer::Base.deliveries.last.to.should == document.emails
      end

      it 'return true' do
        expect(service.create).to be_true
      end
    end

    context 'with stripe errors' do
      before { 
        expect(purchase).to receive(:create).and_return(false)
        expect(purchase).to receive(:errors).and_return(['error1'])
      }

      it 'not change document purchase status' do
        service.create
        expect(document.purchased?).to be_false
      end

      it 'return false' do
        expect(service.create).to be_false
      end
    end
  end
end
