class AddBillableHourToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :billable_hour, :string
  end
end
