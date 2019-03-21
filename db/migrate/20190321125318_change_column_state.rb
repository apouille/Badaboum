class ChangeColumnState < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :state, :integer
    add_column :products, :state, :integer, :default => 1
  end
end
