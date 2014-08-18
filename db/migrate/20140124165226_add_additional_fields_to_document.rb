class AddAdditionalFieldsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :additional_sessions, :string
  end
end
