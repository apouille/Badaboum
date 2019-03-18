class Admin::UsersController < AdminController

	def index
	 @users = User.all
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to request.referer
			flash[:notice] = "Vous avez supprimé un article avec succès"
		end
	end

end
