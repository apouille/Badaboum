class CategoriesController < ApplicationController

	def index
	  @category = Category.find(params[:category])
	  @sizes = Size.all
	  respond_to do |format|
	       format.js {render layout: false}
	  end
	end

end
