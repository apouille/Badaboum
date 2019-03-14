class ChildrenController < ApplicationController

	def new
		@child = Child.new
	end

	def create
		
		if params[:sex] == "Fille"
			sex = 1
		else params[:sex] == "Garçon"
			sex = 2
		end

		@profile = current_user.profile
		@child = Child.new(nickname: params[:nickname],
                  sex: sex,
                  birthday: params[:birthday],
                  profile: current_user.profile,
                  )
		if @child.save
      		redirect_to root_path
      		flash[:success] = "Votre enfant est bien enregistré!"
    	else
      		render 'new'
    	end
	end
end
