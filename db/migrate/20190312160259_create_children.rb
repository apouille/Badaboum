class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.string :nickname
      t.date :birthday
      t.integer :sex

      t.timestamps
    end
  end
end
