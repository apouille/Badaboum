class Admin::ProductsController < AdminController
helper_method :sort_column, :sort_direction

	def index
	 @products = Product.order(sort_column + " " + sort_direction)
	end

	def show
		@product = Product.find(params[:id])
		@seller = @product.seller
		@seller_profile = @seller.profile
		@seller_products = @seller.uploaded_products
	end

	private

	def sort_column
		params[:sort] || "id"
	end

	def sort_direction
		params[:direction] || "desc"
	end

end
