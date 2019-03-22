class SellerMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def notification_comment(user, product)
		# @comment = @product.comments.last
#je recupère le dernier commentaire
		@comment = product.comments.last
		@seller = product.seller
#je recupère le vendeur

    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'

    mail(to: @seller.email, subject: 'Notification de commentaire')
  end

  def confirmation_seller_reservation(seller)
		@seller = seller
    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
    mail(to: @seller.email, subject: 'Vous avez une nouvelle réservation')
  end

  def confirmation_seller_transaction(seller)
    @seller=seller
    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
    mail(to: @seller.email, subject: 'Votre transaction est validée')
  end


  def confirmation_seller_cancellation(seller)
    @seller=seller
    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
    mail(to: @seller.email, subject: 'Une reservation a été annulée')
  end

  def confirmation_seller_refund(seller)
    @seller=seller
    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
    mail(to: @seller.email, subject: "L'annulation est confirmée")
  end

  def seller_dispute_message(seller)
    @seller=seller
    @url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
    mail(to: @seller.email, subject: "Litige ouvert sur Badaboum")
  end

end
