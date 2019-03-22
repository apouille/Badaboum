module WishlistProductsHelper

	def product_is_already_wishlist?(product)
		if  WishlistProduct.find_by(product: product, user: current_user) != nil
			return true
		end
	end

	def transform_product_to_wishlist_product(product)
		wp = WishlistProduct.find_by(product: product)
		return wp
	end


	def user_has_a_wishlist?
		wishlist_products = WishlistProduct.where(user: current_user).all
		unless wishlist_products.size ==  0
			return true
		end
	end

	def number_of_wished_products
		wishlist_products = WishlistProduct.where(user: current_user).all
		unless wishlist_products.size ==  0
			return wishlist_products.length
		end
	end
end
