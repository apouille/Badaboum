class SellerMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def notification_comment(user, product)
		# @comment = @product.comments.last
#je recupère le dernier commentaire
		@comment = product.comments.last
		@seller = product.seller
#je recupère le vendeur

    @url  = 'http://badaboum-demo.herokuapp.com/login'

    mail(to: @seller.email, subject: 'Notification de commentaire')
  end

  def confirmation_seller_reservation(seller)
		@seller = seller
    @url  = 'http://badaboum-demo.herokuapp.com/login'
    mail(to: @seller.email, subject: 'Notification Confirmation Commande')
  end

  def confirmation_seller_transaction(seller)
    @seller=seller
    @url  = 'http://badaboum-demo.herokuapp.com/login'
    mail(to: @seller.email, subject: 'Notification Confirmation Commande')
  end


end