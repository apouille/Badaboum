class Child < ApplicationRecord
	belongs_to :profile
	enum sex: { girl:1, boy:2 }
	validates :nickname,  presence: { message: "Merci de remplir tous les champs obligatoires!" }
end
