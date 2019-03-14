class AddStripeAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_uid, :string
  end
end
