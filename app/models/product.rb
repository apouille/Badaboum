class Product < ApplicationRecord
	belongs_to :seller, class_name:'User'
	belongs_to :category
	belongs_to :size
	enum status: { in_stock:1, selled:2 }

	has_many_attached :pictures

	has_many :comments, dependent: :destroy
	has_one :order

  validates :title, :description, :price, presence: { message: "Merci de remplir tous les champs obligatoires!" };
  validates :description, length: { minimum: 20, message: "La description doit faire au minimum 20 caractères" };
  validates :price, numericality: { greater_than_or_equal_to: 1,  message: "Le prix doit être supérieur ou égal à 1€" };

  scope :cat, -> (category) { where category_id: category }

  end
