class Child < ApplicationRecord
	belongs_to :profile
	enum sex: { girl:1, boy:2 }
	validates :nickname, :birthday, :sex , presence: { message: "Merci de remplir tous les champs du formulaire!" }
	
end
