class CommentsController < ApplicationController

def new
	@comment = Comment.new
end

def create
	@comment = Comment.new(content: params[:content], user: current_user, product_id: params[:product_id])
	@user = current_user

	if @comment.save
		flash[:notice] = "Votre commentaire a été ajouté avec succès"
		SellerMailer.notification_comment(@seller_email).deliver_now
 		redirect_to product_path(params[:product_id])
    else
      render :root_path
	end
end

end
