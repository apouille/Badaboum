class User < ApplicationRecord
  after_create :welcome_send
  after_create :create_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :uploaded_products, foreign_key: 'seller_id', class_name: "Product"
  
  

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def create_profile
    self.create_profile!
  end

end
