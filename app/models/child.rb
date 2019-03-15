class Child < ApplicationRecord
	belongs_to :profile
	enum sex: { girl:1, boy:2 }
	validates :nickname, :birthday, :sex , presence: { message: "Merci de remplir tous les champs du formulaire!" }

	validate :birthday_cannot_be_in_the_futur

  def birthday_cannot_be_in_the_futur
    errors.add(:birthday, "ne peut pas être dans le futur") if birthday > Date.today
  end  
end
