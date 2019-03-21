module Admin::AdminHelper
	def turnover
		turnover = 0
		Order.where(status:3).each do |order| 
			turnover += order.product.price
		end
		return (turnover*0.1).round(2)
	end

end
