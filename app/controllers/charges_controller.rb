class ChargesController < ApplicationController
  before_action :authenticate_user!
	
	def new
	end
  
  def create

	
  	@order = Order.where(user_id: current_user.id, status: 1).last
  	@product =@order.product
  	@amount = @order.product.price*100
  	#@amount_for_seller=(@amount*0.95).to_i
  	@application_fee_amount = (@amount*0.1).to_i
  	@seller_uid = @order.product.seller.stripe_uid

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )
 		charge = Stripe::Charge.create({ customer: customer.id, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', currency: 'eur', transfer_data: {destination: @seller_uid}
})

      @order.update(stripe_customer_id: charge[:customer], status: 2)
      @product.update(status: 2)
      puts @product
      flash[:notice] = 'Votre commande a bien été prise en compte. Vous recevrez un mail de confirmation très prochainement'
      redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  	end

#  def confirmation_send
#    @items = current_user.carts.last.cart_items
#    UserMailer.confirmation_email(current_user, @items).deliver_now
#  end
#
#  def new_order_send
#    @cart_items = current_user.carts.last.cart_items
#    AdminMailer.new_order_email(current_user, @cart_items).deliver_now
#  end
end