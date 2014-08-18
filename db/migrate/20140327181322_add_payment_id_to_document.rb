class AddPaymentIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :stripe_payment_id, :string
  end
end
