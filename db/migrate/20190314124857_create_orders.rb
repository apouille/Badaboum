class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
