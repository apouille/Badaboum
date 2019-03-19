class AddNotationToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :notation, :integer
  end
end
