class Order < ApplicationRecord
	belongs_to :user
	belongs_to :product

	enum status: { in_progress:1, paid_with_stripe:2, completed:3, disputed:4, refunded:5 }
	validates :status, presence:true
end
