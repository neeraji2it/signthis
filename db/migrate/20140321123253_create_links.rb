class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :document
      t.string :key, index: {unique: true}

      t.timestamps
    end
  end
end
