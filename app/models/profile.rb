class Profile < ApplicationRecord
	has_one_attached :profil_picture
	belongs_to :user
	has_many :children
	geocoded_by :address
	after_validation :geocode, :on => :update

	validates :first_name, :last_name, :street, :city, :zip_code, :country, presence: { message: "Merci de remplir tous les champs obligatoires!" }, :on => :update
	validates :zip_code, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[abAB]))[0-9]{3}\z/, message: "Le code postal est invalide" }, :on => :update

	validates :phone_number,:allow_blank => true, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "Entrez un numéro français, s'il vous plait !" }, :on => :update

	

	def address
		[street, city, country].compact.join(", ")
	end



end
