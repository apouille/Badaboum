class Order < ApplicationRecord
	belongs_to :user
	belongs_to :product
	validates :notation, numericality: { only_integer: true }
	enum status: { in_progress:1, paid_with_stripe:2, completed:3, disputed:4 }
	validates :status, presence:true
end
