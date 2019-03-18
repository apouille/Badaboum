class ChildrenController < ApplicationController

	def new
		@child = Child.new
	end

	def create
    @profile = current_user.profile

    params[:sex] == "Fille" ? sex = 1 : sex = 2
		
		@child = Child.new(nickname: params[:nickname], sex: sex, birthday: params[:birthday], profile: @profile)
		if @child.save
      redirect_to root_path
      flash[:success] = "Votre enfant est bien enregistré!"
    else
      redirect_back fallback_location: root_path
    end
	end
end
