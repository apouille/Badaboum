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

	def user_has_sold?
		result = false
		@all_orders=Order.all
		puts @all_orders
		@all_orders.each do |order|
			if (order.product.seller.id == current_user.id) 
			result = true
			end
		end
		return result
	end


	def user_has_bought?
		return true unless Order.where(user:current_user) == nil
	end

end
