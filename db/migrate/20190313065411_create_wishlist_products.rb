class CreateWishlistProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlist_products do |t|

      t.timestamps
    end
  end
end
