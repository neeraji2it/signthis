class NewPurchaseMailer < ActionMailer::Base
  include Sidekiq::Mailer

  default from: "welcome@wevorce.com"

  def send_notification(emails, cardholder_name)
    @cardholder_name = cardholder_name
    mail(to: emails, bcc: ['welcome@wevorce.com'], subject: 'Wevorce receipt')
  end
end
