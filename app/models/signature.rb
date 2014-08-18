class Signature < ActiveRecord::Base
  before_save :deactivate, if: :data_changed?

  def document
    Document.where(['first_spouse_signature_id = ? OR second_spouse_signature_id = ?', id, id]).first
  end

  def empty?
    data.blank?
  end

  def updated_at
    empty? ? nil : super
  end

  def updated_at_in_miliseconds
    updated_at.to_i * 1000 if updated_at
  end

  private

  def deactivate
    assign_attributes(active: false) if present?
  end
end
