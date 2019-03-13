class AddForeignKeysToWishlistProducts < ActiveRecord::Migration[5.2]
def change
  add_reference :wishlist_products, :product, foreign_key: true
  add_reference :wishlist_products, :user, foreign_key: true
end
end
