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

	  	#Variable pour le paiment stripe
	  	@amount = @order.product.price*100
	  	@application_fee_amount = (@amount*0.1).to_i
	  	@seller_uid = @order.product.seller.stripe_uid
	    customer = @order.stripe_customer_id
    
	    #admin remet dans son état initial de vente
		if @status == 1
			@order.update(status: @status)
			@product.update(state:1)
			redirect_to admin_orders_path

		#admin met le produit en réservation
		elsif @status == 2
			@order.update(status: @status)
			@product.update(state:2)
			redirect_to referrer.require

	    #admin force la réalisation de la vente
		elsif @status == 3
	  		charge = Stripe::Charge.create({ currency: 'eur', customer: customer, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', currency: 'eur', transfer_data: {destination: @seller_uid}
		})
	  		@order.update(status: @status)
	  		@product.update(state:2)
			redirect_to referrer.require
		
		#admin déclenche la demande d'annulation la vente
		elsif @status == 4
			@order.update(status: @status)
			@product.update(state:2)
			redirect_to referrer.require

		#admin déclenche l'annulation de la vente
		elsif @status == 5
			@order.update(status: @status)
			@product.update(state:1)		
		end
	end

end
