require 'spec_helper'

describe Link do
  it { should belong_to(:document) }

  it { should validate_uniqueness_of(:key) }
  it { should validate_presence_of(:key) }

  context 'key generation' do
    let!(:doc) { create :document }

    it 'generate after initialization' do
      link = Link.new document: doc
      expect(link.key).to_not be_blank
      expect(link).to be_valid
    end

    it 'regenerate after key duplication' do
      link = Link.create document: doc
      expect(SecureRandom).to receive(:urlsafe_base64).with(nil, false).and_return(link.key).and_call_original
      # There will be two loop calls there
      new_link = Link.new document: doc
      expect(new_link).to be_valid
    end
  end
end
