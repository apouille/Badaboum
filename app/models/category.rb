class Category < ApplicationRecord
	belongs_to :product

	validates :title, presence:true
end
