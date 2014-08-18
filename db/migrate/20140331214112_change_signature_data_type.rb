class ChangeSignatureDataType < ActiveRecord::Migration
  def up
    ids = Signature.all.reject(&:empty?).map(&:id)
    Signature.where(id: ids).update_all(data: 'THERE WAS OLD SIGNATURE')

    change_column :signatures, :data, :string, default: "" 
  end

  def down
    change_column :signatures, :data, :text, default: "{\"lines\":[]}"
  end
end
