require 'spec_helper'

describe Document do
  it { should belong_to(:architect) }
  it { should belong_to(:first_spouse_signature) }
  it { should belong_to(:second_spouse_signature) }
  it { should have_one(:link) }

  let(:signature) { build_stubbed :signature, data: 'x' }
  let(:empty_signature) { build_stubbed :signature, data: nil }

  context 'before creating inactive document' do
    let(:document) { create :document, first_spouse_signature: nil, second_spouse_signature: nil }

    it 'creates inactive first spouse signature' do
      expect(document.first_spouse_signature).to be_persisted
      expect(document.first_spouse_signature.active?).to be_false
    end

    it 'creates inactive second spouse signature' do
      expect(document.second_spouse_signature).to be_persisted
      expect(document.second_spouse_signature.active?).to be_false
    end
  end

  context 'before creating active document' do
    let(:document) { create :document, first_spouse_signature: nil, second_spouse_signature: nil , active: true}

    it 'creates active first spouse signature' do
      expect(document.first_spouse_signature).to be_persisted
      expect(document.first_spouse_signature.active?).to be_true
    end

    it 'creates active second spouse signature' do
      expect(document.second_spouse_signature).to be_persisted
      expect(document.second_spouse_signature.active?).to be_true
    end
  end

  context 'before updating active document' do
    let!(:document) { create :document }

    it 'make first signature active' do
      document.update!({active: true})
      expect(document.first_spouse_signature.active?).to be_true
    end

    it 'make second signature active' do
      document.update!({active: true})
      expect(document.second_spouse_signature.active?).to be_true
    end
  end

  context 'before updating inactive document' do
    let!(:document) { create :document }

    it 'does not change first spouse signature' do
      document.update!({active: false})
      expect(document.first_spouse_signature.active?).to be_false
    end

    it 'does not change second spouse signature' do
      document.update!({active: false})
      expect(document.second_spouse_signature.active?).to be_false
    end
  end

  describe '#editable?' do
    it 'true if document unsigned' do
      document = build_stubbed :document, first_spouse_signature: empty_signature, second_spouse_signature: empty_signature
      expect(document.editable?).to be_true
    end

    it 'false if one sign created' do
      document = build_stubbed :document, first_spouse_signature: empty_signature, second_spouse_signature: signature
      expect(document.editable?).to be_false
    end

    it 'false if both signs created' do
      document = build_stubbed :document, first_spouse_signature: signature, second_spouse_signature: signature
      expect(document.editable?).to be_false
    end
  end

  describe '#emails' do
    it 'return emails array' do
      document = build_stubbed :document, first_spouse_email: 'test@example.com', second_spouse_email: nil
      expect(document.emails).to eq ['test@example.com']
    end

    it 'return empty array if there arent any email' do
      document = build_stubbed :document, first_spouse_email: nil, second_spouse_email: nil
      expect(document.emails).to be_empty
    end
  end

  describe '#purchased?' do
    it 'true if stripe payment id exists' do
      document = build_stubbed :document, stripe_payment_id: '1xxp_343'
      expect(document.purchased?).to be_true
    end

    it 'false unless stripe payment id exists' do
      document = build_stubbed :document, stripe_payment_id: nil
      expect(document.purchased?).to be_false
    end
  end

  describe '#signed?' do
    it 'true if all signes present' do
      document = build_stubbed :document, first_spouse_signature: signature, second_spouse_signature: signature
      expect(document.signed?).to be_true
    end

    it 'false if one of signes is empty' do
      document = build_stubbed :document, first_spouse_signature: signature, second_spouse_signature: empty_signature
      expect(document.signed?).to be_false
    end
  end

  describe '.build' do
    it 'initialize new document' do
      document = Document.build first_spouse_email: 'test@test.test'
      expect(document).to be_a Document
      expect(document.first_spouse_email).to eq 'test@test.test'
      expect(document).to_not be_persisted
    end

    it 'add architect as second argument' do
      user = build :user
      document = Document.build({first_spouse_email: 'test@test.test'}, user)
      expect(document.architect).to eq user
    end
  end
end
