class Product < ApplicationRecord
	belongs_to :seller, class_name:'User'
	belongs_to :category
	belongs_to :size
	enum state: { in_stock:1, sold:2, inactive:3 }
	enum condition: { Neuf:1, Bon:2, Moyen:3, Mauvais:4, Dégradé:5 }

	has_many_attached :pictures

	has_many :comments, dependent: :destroy
	has_many :wishlist_products, dependent: :destroy
	has_one :order

  validates :state, presence:true
  validates :title, :description, :price, :condition, :category, presence: { message: ": Ce champs est obligatoire!" };
  validates :description, length: { minimum: 20, message: " La description doit faire au minimum 20 caractères" };
  validates :price, numericality: { greater_than_or_equal_to: 1,  message: "Le prix doit être supérieur ou égal à 1€" };

  scope :cat, -> (category) { where category_id: category }
  scope :price, -> (price) { reorder(price: price) }
  scope :siz, -> (size) { where size_id: size }
  scope :brand, -> (brand) {where brand: brand }

  def self.brand_array(current_category)
    brand_array = []
    self.all.cat(current_category).each do |product|
      brand_array << product.brand
    end
    return brand_array.uniq
  end

end

