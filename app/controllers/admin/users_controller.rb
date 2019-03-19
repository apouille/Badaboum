class Admin::UsersController < AdminController

	def index
	 @users = User.all
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile
		@wishlist_products = WishlistProduct.where(user: @user).all
	end

end
