class Order < ApplicationRecord
	enum status: { in_progress:1, paid_with_stripe:2 }
	belongs_to :user
	belongs_to :product
end
