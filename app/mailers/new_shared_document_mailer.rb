class NewSharedDocumentMailer < ActionMailer::Base
  include Sidekiq::Mailer

  default from: "welcome@wevorce.com"

  helper :application
  helper :documents
  helper :signatures
  helper :mailer

  # TODO: fix this
  include ActionController::HideActions
  include Clearance::Authentication
  def signed_in?
    true
  end

  def send_document(emails, document_id)
    @document = Document.find(document_id)
    @document.create_link! unless @document.link
    @document = @document.decorate
    mail(to: emails, bcc: ['welcome@wevorce.com'], subject: 'Wevorce mediation agreement')
  end

  def send_document_blueprint(emails, document_attributes)
    @document = Document.new(document_attributes).decorate
    attachments[attachment_name_blueprint] = pdf_blueprint
    mail(to: emails, bcc: ['welcome@wevorce.com'], subject: 'Wevorce mediation agreement blueprint')
  end

  def pdf_blueprint(options={})
    options.merge!(default_options_for_document_blueprint)
    WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: attachment_name_blueprint,
        template: 'documents/edit',
        layout: 'application.pdf.html',
      ), options)
  end

  private

  def attachment_name_blueprint
    "#{@document.filename}-blueprint.pdf"
  end

  def default_options_for_document_blueprint
    {margin: {top: 0, left: 0, right: 0}}
  end
end
