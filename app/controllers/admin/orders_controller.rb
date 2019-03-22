class Admin::OrdersController < AdminController

	def index
		@orders = Order.all
	end

	def show
	end

	def update
		@status = params[:admin_status].to_i
		@order=Order.find(params[:id])
	  	@product =@order.product

	  	#variables pour le paiment stripe
	  	@amount = @order.product.price*100
	  	@application_fee_amount = (@amount*0.1).to_i
	  	@seller_uid = @order.product.seller.stripe_uid
	    customer = @order.stripe_customer_id

	    #admin force la réalisation de la vente
		if @status == 3
	  		charge = Stripe::Charge.create({ currency: 'eur', customer: customer, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', currency: 'eur', transfer_data: {destination: @seller_uid}
		})
	  		@order.update(status: @status)
	  		@product.update(state:'sold')
			redirect_back fallback_location: admin_orders_path

		#admin déclenche l'annulation de la vente
		elsif @status == 5
			@order.update(status: @status)
			@product.update(state:'in_stock')
			redirect_back fallback_location: admin_orders_path
		end
	end

end
