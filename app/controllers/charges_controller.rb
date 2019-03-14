class ChargesController < ApplicationController

before_action :authenticate_user!

	
   	def create
		
		@amount = 1000
		@profile_current_user = current_user.profile

		percentage = @amount * 0.05

		  customer = Stripe::Customer.create({
		    email: params[:stripeEmail],
		    source: params[:stripeToken],
		  })


		  charge = Stripe::Charge.create({
		    customer: customer.id,
		    amount: @amount,
		    description: 'Rails Stripe customer',
		    currency: 'eur',
		    application_fee: percentage
			  },
			stripe_account: Product.all.first.seller.stripe_uid
		  )


	  @cart.update(stripe_customer_id: charge[:customer], status: 1)
	  flash[:notice] = "Your order is complete"
	  redirect_to profile_path(@profile_current_user.id)

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
		end

		def confirmation_send
			@items = current_user.carts.last.cart_items
      UserMailer.confirmation_email(current_user, @items).deliver_now
    end

		def new_order_send
			@cart_items = current_user.carts.last.cart_items
      AdminMailer.new_order_email(current_user, @cart_items).deliver_now
    end
end






Stripe::Charge.create(
            {
                :amount => ticket.price * 100,
                :description => ticket.description,
                :currency => 'usd',
                :source => "tok_visa",
                :application_fee => percentage,
            },
            :stripe_account => ticket.user.stripe_uid
        )