class CommentsController < ApplicationController

after_action :notification_comment, only: [:create]

	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(content: params[:content], user: current_user, product_id: params[:product_id])
		@user = current_user

		if @comment.save
			flash[:notice] = "Votre commentaire a été ajouté avec succès"
	 		redirect_to product_path(params[:product_id])
	    else
	      render :root_path
		end
	end

	def notification_comment
		puts "*"*30
		puts params
		puts "*"*30
		@product = Product.find(params[:product_id])
		SellerMailer.notification_comment(current_user, @product).deliver_now
	end

end

