class UserMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def welcome_email(user)
		@user = user
		@url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Inscription Badaboum')
	end

	def confirmation_buyer_reservation(user)
		@user = user
		@url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Votre réservation est validée')
	end


	def confirmation_buyer_transaction(user)
		@url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: user.email, subject: 'Votre transaction est validée')
	end

	def confirmation_buyer_cancellation(user)
		@url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: user.email, subject: "Votre demande d'annulation est prise en compte")
	end

	def confirmation_buyer_refund(user)
		@url  = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: user.email, subject: "L'annulation est confirmée")
	end

	def new_private_message(user)
		@user = user
		@url = 'http://badaboum-prod.herokuapp.com/conversations'
		mail(to: @user.email, subject: 'Nouveau message sur Badaboum')
	end

	# mail à l'ouverture d'un litige
	def buyer_dispute_message(user)
		@user = user
		@url = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Litige ouvert sur Badaboum')
	end

	# mail suite litige - confirmation vente
	def buyer_dispute_order_confirmed(user)
		@user = user
		@url = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Litige traité sur Badaboum - achat confirmé')
	end

	# mail suite litige - annulation vente
	def buyer_dispute_order_cancelled(user)
		@user = user
		@url = 'http://badaboum-prod.herokuapp.com/users/sign_in'
		mail(to: @user.email, subject: 'Litige traité sur Badaboum - achat annulé')
	end

end
