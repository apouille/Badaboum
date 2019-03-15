class Child < ApplicationRecord
	belongs_to :profile
	enum sex: { girl:1, boy:2 }
	validates :nickname, :birthday, :sex, presence: { message: "Merci de remplir tous les champs du formulaire!" }

	validate :birthday_cannot_be_in_the_futur

  def birthday_cannot_be_in_the_futur
    errors.add(:birthday, "La date de naissance ne peut pas être dans le passé") if
      !birthday.blank? and birthday > Date.today
  end
end
