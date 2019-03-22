class Order < ApplicationRecord
	belongs_to :user
	belongs_to :product

	enum status: {cart:1, reservation:2, confirmation:3, cancellation_request:4, cancellation:5, dispute: 6}
	validates :status, presence:true
  validates :notation, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
