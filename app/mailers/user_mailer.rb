class UserMailer < ApplicationMailer
	default from: 'no-reply@badaboum.fr'

	def welcome_email(user)
		@user = user
		@url  = 'http://badaboum-demo.herokuapp.com/login' 
		mail(to: @user.email, subject: 'Bienvenue chez nous !') 
	end
	
end
