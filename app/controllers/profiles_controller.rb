class ProfilesController < ApplicationController

	before_action :authenticate_user!

	def show
		@profile = current_user.profile
		@children = Child.where(profile_id: @profile.id)
    @products = current_user.uploaded_products.order(created_at: :desc)
  end

	def edit
		@profile = current_user.profile
		@child = Child.new
	end

	def update
		@profile = current_user.profile

    if @profile.update profile_params
    	if params[:profil_picture].present?
        @profile.profil_picture.attach(params[:profil_picture])
    	end
      redirect_back fallback_location: root_path 
      flash[:succes] = "Profil mis à jour!"    
    else
      render 'edit'
      flash[:error] = "Le profil n'a pas pu être mis à jour!" 
    end
  end

	private

    def profile_params
      params.permit(:first_name, :last_name, :phone_number, :street, :city, :zip_code, :description)
    end
end
