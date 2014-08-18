class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.text :data, default: "{\"lines\":[]}"
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
