class AddSpouseEmailsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :first_spouse_email, :string
    add_column :documents, :second_spouse_email, :string
  end
end
