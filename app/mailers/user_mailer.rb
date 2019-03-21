class UserMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def welcome_email(user)
		@user = user
		@url  = 'http://badaboum-demo.herokuapp.com/login'
		mail(to: @user.email, subject: 'Inscription Badaboum.com')
	end

  def confirmation_buyer_reservation(user)
  	@user = user
    @url  = 'http://badaboum-demo.herokuapp.com/login'
    mail(to: @user.email, subject: 'Notification Confirmation Achat')
  end


   def confirmation_buyer_transaction(user)
    @url  = 'http://badaboum-demo.herokuapp.com/login'
    mail(to: user.email, subject: 'Notification Confirmation Achat')
  end
  

  def new_private_message(user)
    @user = user
    @url = 'http://badaboum-demo.herokuapp.com/conversations'
    mail(to: @user.email, subject: 'Nouveau message sur Badaboum')
  end


end
