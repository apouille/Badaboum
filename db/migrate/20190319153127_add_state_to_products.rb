class AddStateToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :condition, :integer
  end
end
