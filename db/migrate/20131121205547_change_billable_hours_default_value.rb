class ChangeBillableHoursDefaultValue < ActiveRecord::Migration
  def up
    change_column :documents, :billable_hour, :string, default: '600.00'
  end

  def down
    change_column :documents, :billable_hour, :string
  end
end
