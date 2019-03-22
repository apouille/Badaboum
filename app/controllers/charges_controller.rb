class ChargesController < ApplicationController
  before_action :authenticate_user!
	after_action :confirmation_buyer_reservation, only: [:create]
  after_action :confirmation_seller_reservation, only: [:create]

	def new
	end
  
  def create

  	@order = Order.where(user_id: current_user.id, status: 'cart').last
  	@product =@order.product
  	@amount = @order.product.price*100
  	@application_fee_amount = (@amount*0.1).to_i
  	@seller_uid = @order.product.seller.stripe_uid

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )

      @order.update(stripe_customer_id: customer.id, status: 'reservation')
     
      @product.update(state: 'sold')
      flash[:notice] = 'Votre commande a bien été prise en compte. Vous recevrez un mail de confirmation très prochainement'
      redirect_to orders_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  	end


   def confirmation_buyer_reservation
     UserMailer.confirmation_buyer_reservation(current_user).deliver_now
   end

   def confirmation_seller_reservation
     SellerMailer.confirmation_seller_reservation(@order.product.seller).deliver_now
   end

end