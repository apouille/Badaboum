class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.string :brand
      t.string :color
      t.integer :size

      t.timestamps
    end
  end
end
