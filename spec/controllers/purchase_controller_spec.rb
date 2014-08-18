require 'spec_helper'

describe PurchaseController do
  describe 'POST create' do
    let!(:document) { create :document }
    let!(:link) { create :link, key: '123', document_id: document.id }

    let(:do_request) { post :create, key: '123', purchase: {card_code: '123', stripe_card_token: 'tkn123'} }

    context 'with successfull payment' do
      before { DocumentPaymentService.any_instance.should_receive(:create).and_return(true) }

      it 'redirect to public document url' do
        do_request
        expect(response).to redirect_to public_documents_url(key: '123')
      end

      it 'assign document and purchase' do
        do_request
        expect(assigns(:document)).to eq document
        expect(assigns(:purchase)).to be_a Purchase
      end

      it 'decorate document' do
        do_request
        expect(assigns(:document)).to be_decorated
      end
    end

    context 'with failure payment' do
      before { DocumentPaymentService.any_instance.should_receive(:create).and_return(false) }

      it 'decorate document' do
        do_request
        expect(assigns(:document)).to be_decorated
      end

      it 'assign document and purchase' do
        do_request
        expect(assigns(:document)).to eq document
        expect(assigns(:purchase)).to be_a Purchase
      end

      it 'render document/show template' do
        do_request
        expect(assigns(:document)).to render_template('documents/show')
      end

      it 'add alert with message' do
        do_request
        expect(response.request.flash[:alert]).to eq 'There was a problem with payment'
      end
      
    end
  end
end
