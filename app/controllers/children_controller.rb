class ChildrenController < ApplicationController

	def new
		@child = Child.new
	end

	def create
		
		@profile = current_user.profile
		@child = Child.new(nickname: params[:nickname],
                  sex: params[:sex],
                  birthday: params[:birthday],
                  profile: profile,
                  )
		if @child.save
      		redirect_to root_path
      		flash[:success] = "Le produit est bien enregistré!"
    	else
      		render 'new'
    	end
	end
end
