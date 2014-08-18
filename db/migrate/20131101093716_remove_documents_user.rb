class RemoveDocumentsUser < ActiveRecord::Migration
  def up
    drop_table :documents_users
  end

  def down
    create_table :documents_users do |t|
      t.references :user, null: false
      t.references :document, null: false
    end

    add_index :documents_users, [:user_id, :document_id], unique: true
  end
end
