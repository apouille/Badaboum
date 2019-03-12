class User < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  has_many :uploaded_products, foreign_key: 'seller_id', class_name: "Product"
  
  

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
