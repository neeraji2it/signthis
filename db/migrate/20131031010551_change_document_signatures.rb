class ChangeDocumentSignatures < ActiveRecord::Migration
  def up
    add_column :documents, :first_spouse_signature_id, :integer
    add_column :documents, :second_spouse_signature_id, :integer

    remove_column :documents, :first_signature
    remove_column :documents, :second_signature
    remove_column :documents, :first_signature_updated_at
    remove_column :documents, :second_signature_updated_at
    remove_column :documents, :waiting_for_second_signature
    remove_column :documents, :waiting_for_first_signature
  end

  def down
    remove_column :documents, :first_spouse_signature_id
    remove_column :documents, :second_spouse_signature_id

    add_column :documents, :first_signature, :text, default: "{\"lines\":[]}"
    add_column :documents, :second_signature, :text, default: "{\"lines\":[]}"
    add_column :documents, :waiting_for_first_signature, :boolean, default: false
    add_column :documents, :waiting_for_second_signature, :boolean, default: false
    add_column :documents, :first_signature_updated_at, :datetime
    add_column :documents, :second_signature_updated_at, :datetime
  end
end
