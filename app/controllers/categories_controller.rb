class CategoriesController < ApplicationController

	def index
	  @category = Category.find(params[:category])
	  @sizes = Size.all
	  @last_size = Size.last
	  respond_to do |format|
	       format.js {render layout: false}
	  end
	end

end
