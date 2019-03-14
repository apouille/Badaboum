class CommentsController < ApplicationController

def new
	@comment = Comment.new
end

def create
	@comment = Comment.new(content: params[:content], user: current_user, product_id: params[:product_id])

puts "*"*30
puts params
puts "*"*30

	if @comment.save
		flash[:notice] = "Votre commentaire a été ajouté avec succès"
 		redirect_to product_path(params[:product_id])
    else
      render :root_path
	end
end

end