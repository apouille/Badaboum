class SellerMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def notification_comment(user)
		@seller_email = "melanie@yopmail.com"

    @url  = 'http://badaboum-demo.herokuapp.com/login'

    mail(to: @seller_email, subject: 'Notification de commentaire')

  end


end
