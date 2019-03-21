class Admin::AdminController < AdminController

	def index
		@user = User.all
		@orders = Order.all
	end

end
