require "spec_helper"

describe NewPurchaseMailer do
  let(:emails) { ['test@example.com', 'test2@example.com'] }

  describe '.send_document' do
    let(:mail) { NewPurchaseMailer.send_notification(emails, "FULL NAME") }

    it 'has subject' do
      expect(mail.subject).to eq 'Wevorce receipt'
    end

    it 'send from ecosign@wevorce.com' do
      expect(mail.from).to eq ['welcome@wevorce.com']
    end

    it 'send to user email' do
      expect(mail.to).to eq emails
    end

    it 'has name in body' do
      expect(mail.body).to match(/FULL NAME/)
    end
  end
end
