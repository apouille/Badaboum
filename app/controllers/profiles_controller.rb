class ProfilesController < ApplicationController
	def show
		@profile = current_user.profile
	end 

	def edit 
	end 

	def update
	end 
end
