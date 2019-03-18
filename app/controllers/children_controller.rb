class ChildrenController < ApplicationController

	def new
		@child = Child.new
	end

	def create
    @profile = current_user.profile

    params[:sex] == "Fille" ? sex = 1 : sex = 2
	@nickname = params[:nickname]
	@child = Child.new(nickname: params[:nickname], sex: sex, birthday: params[:birthday], profile: @profile)
		if @child.save
			flash[:success] = "#{@nickname} a bien été ajouté"
	    	redirect_to profile_path
	      
	    else
	    	flash[:error] = "Veuillez remplir tous les champs"
	    	redirect_back fallback_location: edit_profile_path
	    end
	end
end
