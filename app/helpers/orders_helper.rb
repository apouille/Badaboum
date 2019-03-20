module OrdersHelper

	def countdown(order)
		countdown = (order.updated_at + 30.days - Time.now)/1.day.to_i
	end

	def deadline(order)
		order.updated_at + 30.days
	end


	def blank_stars(order)
 	5 - order.notation.to_i
	end
end
