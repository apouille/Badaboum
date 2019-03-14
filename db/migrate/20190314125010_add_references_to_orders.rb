class AddReferencesToOrders < ActiveRecord::Migration[5.2]
  def change
  	 add_reference :orders, :user, foreign_key: true
  	  add_reference :orders, :product, foreign_key: true
  end
end
