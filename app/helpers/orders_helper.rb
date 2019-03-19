module OrdersHelper

	def countdown(order)
		countdown = (order.updated_at + 30.days - Time.now)/1.day.to_i
	end

	def deadline(order)
		order.updated_at + 30.days
	end
end
