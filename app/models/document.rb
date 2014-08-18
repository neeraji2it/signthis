class Document < ActiveRecord::Base
  # order is important
  OPTIONS_ATTRIBUTES = %w[foundation_building parenting_planning_i parenting_planning_ii parenting_planning_iii fiscal_mapping fiscal_mapping_ii fiscal_mapping_iii document_prepping final_review]

  DEFAULT_PRICE = 50000

  attr_accessor :active

  belongs_to :architect, class_name: 'User'

  belongs_to :first_spouse_signature, class_name: 'Signature'
  belongs_to :second_spouse_signature, class_name: 'Signature'

  before_create :create_signatures, unless: :active
  before_create :create_active_signatures, if: :active

  before_update :update_signatures_status, if: :active

  has_one :link

  def public_key
    link.key if link
  end

  def editable?
    first_spouse_signature.blank? && second_spouse_signature.blank?
  end

  def signed?
    first_spouse_signature.present? && second_spouse_signature.present?
  end

  def purchased?
    !!stripe_payment_id
  end

  def send_by_email
    NewSharedDocumentMailer.send_document(emails, id).deliver if emails.any? && persisted?
  end

  def send_blueprint_by_email
    NewSharedDocumentMailer.send_document_blueprint(emails, attributes).deliver if emails.any?
  end

  def self.build(params, architect=nil)
    doc = Document.new params
    doc.architect = architect
    doc
  end

  def emails
    [first_spouse_email, second_spouse_email].reject(&:blank?)
  end

  private

  def create_signatures
    create_first_spouse_signature
    create_second_spouse_signature
  end

  def create_active_signatures
    create_first_spouse_signature(active: true)
    create_second_spouse_signature(active: true)
  end

  def update_signatures_status
    first_spouse_signature.update!(active: true)
    second_spouse_signature.update!(active: true)
  end
end
