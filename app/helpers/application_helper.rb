module ApplicationHelper
	
	def bootstrap_class_for_flash(type)
	  case type
	    when 'notice' then "alert-info"
	    when 'success' then "alert-success"
	    when 'error' then "alert-danger"
	    when 'alert' then "alert-warning"
	  end
	end



	def sortable(column, title = nil)
	  title ||= column.titleize
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction}
	end

	def average_notation(user)
	    number_of_stars = 0
	    number_of_notation = 0

	    Order.where(status: 3).all.each do |order|
	      if (order.product.seller == user) 
	       number_of_notation+=1
	       number_of_stars += order.notation.to_i
	      end
	    end
	
	    if number_of_notation != 0
	    return (number_of_stars/number_of_notation).round
		end
	end

	def has_notation?(user)
		result = false 
		Order.where(status: 3, notation: 1..5).all.each do |order|
			if (order.product.seller.id == user.id) 
				puts '$'*100
				puts order.product.seller
				puts order.product.seller.profile.first_name
				puts order.notation
				result = true
			end
		end
		return result
	end

end