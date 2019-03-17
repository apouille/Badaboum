class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :product	
	validates :content, presence: { message: "Merci de remplir tous les champs du formulaire!" }
end
