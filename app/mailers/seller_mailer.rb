class SellerMailer < ApplicationMailer

	def notification_comment(seller,comment)
		@product = Product.find(params[:id])
		@seller_profile = @product.seller.profile
		@comment = comment
		@url = 'http://badaboum-demo.herokuapp.com/login'
		mail(to: @product.seller.profile.email, subject: 'Notification Produit Badaboum') 
	end
	
end
