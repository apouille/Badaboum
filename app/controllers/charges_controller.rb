class ChargesController < ApplicationController
  before_action :authenticate_user!
	
	def new
	end
  
  def create

		puts '$'*50
  	puts 'hellooooooo'
  	@order = Order.find(params[:id])
  	puts '$'*50
  	puts @order.id

  	@amount = @order.product.price
  	puts '$'*50
  	puts @amount

  	@amount_for_seller=(@amount*0.95).to_i
  	puts '$'*50
  	puts @amount_for_seller

  	@seller_uid = @order.product.seller.stripe_uid
  	puts '$'*50
  	puts 	@seller_uid


    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )

    puts '$'*50
  	puts customer.id


  
 	charge = Stripe::Charge.create({ customer: customer.id, amount: @amount, description: 'Rails Stripe customer', currency: 'eur', transfer_data: {amount: @amount_for_seller, destination: @seller_uid}
})

      @order.update(stripe_customer_id: charge[:customer], status: 2)
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