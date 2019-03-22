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

	  	charge = Stripe::Charge.create({ currency: 'eur', customer: customer, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', transfer_data: {destination: @seller_uid}
		})
  		@order.update(status: @status)
  		@product.update(state:'sold')

  		# mailers
  		seller_dispute_order_confirmed
  		buyer_dispute_order_confirmed

			redirect_back fallback_location: admin_orders_path

		#admin déclenche l'annulation de la vente
		elsif @status == 5
			@order.update(status: @status)
			@product.update(state:'in_stock')

			# mailers
			seller_dispute_order_cancelled
			buyer_dispute_order_cancelled

			redirect_back fallback_location: admin_orders_path

		end
	end

	private

		# mailers order confirmed following a dispute
		def seller_dispute_order_confirmed
			SellerMailer.seller_dispute_order_confirmed(@order.product.seller).deliver_now
		end
		def buyer_dispute_order_confirmed
			UserMailer.buyer_dispute_order_confirmed(@order.user).deliver_now
		end

		# mailers order cancelled following a dispute
		def seller_dispute_order_cancelled
			SellerMailer.seller_dispute_order_cancelled(@order.product.seller).deliver_now
		end
		def buyer_dispute_order_cancelled
			UserMailer.buyer_dispute_order_cancelled(@order.user).deliver_now
		end

end
