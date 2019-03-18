class UserMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def welcome_email(user)
		@user = user
		@url  = 'http://badaboum-demo.herokuapp.com/login' 
		mail(to: @user.email, subject: 'Inscription Badaboum.com') 
	end

  def confirmation_purchase(user)
  	@user = user
    @url  = 'http://badaboum-demo.herokuapp.com/login'
    mail(to: @user.email, subject: 'Notification Confirmation Achat')
  end
  
end
