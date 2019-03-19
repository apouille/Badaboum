class AdminController < ApplicationController

	def require_admin
	  unless current_user.try(:is_admin?)
	  	flash[:error] = "Accès non autorisé"
	  	redirect_to root_path
	  end
  end

end
