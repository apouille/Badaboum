class Product < ApplicationRecord
	belongs_to :seller, class_name:'User'
	has_one :category

	validates :title, :description, :price, presence: { message: "Merci de remplir tous les champs obligatoires!" };
  validates :description, length: { minimum: 20, message: "La description doit faire au minimum 20 caractères" };
  validates :price, numericality: { greater_than: 1,  message: "Le prix doit être supérieur à 1€" };
  end
