class Category < ApplicationRecord
	has_many :products

	validates :title, presence: true
	validates :icon, presence: true 
end
