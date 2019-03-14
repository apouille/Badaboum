class RemoveSizeToProducts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :size, :integer
  end
end
