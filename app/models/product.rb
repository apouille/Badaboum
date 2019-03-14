class Product < ApplicationRecord
	belongs_to :seller, class_name:'User'
	belongs_to :category
	belongs_to :size

	has_many_attached :pictures

  validates :title, :description, :price, presence: { message: "Merci de remplir tous les champs obligatoires!" };
  validates :description, length: { minimum: 20, message: "La description doit faire au minimum 20 caractères" };
  validates :price, numericality: { greater_than: 1,  message: "Le prix doit être supérieur à 1€" };

  scope :category, -> (category_id) { where category_id: category_id }
  scope :taille, -> (size_id) { where size_id: size_id }
  end
