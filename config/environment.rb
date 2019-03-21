# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_LOGIN'],
  :password => ENV['SENDGRID_PWD'],
  :domain => 'http://badaboum-demo.herokuapp.com/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}


# Show 404 errors
SHOW_404 = true
# Show error template (or render extended Rails info)
SHOW_EXTENDED_404 = false
# Don't show 500 - instead render 404 
SHOW_ONLY_404 = false
