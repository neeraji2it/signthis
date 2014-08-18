require "spec_helper"

describe NewSharedDocumentMailer do
  let(:emails) { ['test@example.com', 'test2@example.com'] }
  let(:document) { create :document }

  describe '.send_document' do
    let(:mail) { NewSharedDocumentMailer.send_document(emails, document.id) }

    it 'has subject' do
      expect(mail.subject).to eq 'Wevorce mediation agreement'
    end

    it 'send from ecosign@wevorce.com' do
      expect(mail.from).to eq ['welcome@wevorce.com']
    end

    it 'send to user email' do
      expect(mail.to).to eq emails
    end
  end
end
