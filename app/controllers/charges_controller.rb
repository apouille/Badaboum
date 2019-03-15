class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
  	@order = Order.create(user_id: current_user.id, product_id: Product.find(1).id, status: 1)
  	@amount = 1000
    @profile_current_user = current_user.profile

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )


  
 	charge = Stripe::Charge.create({ customer: 'cus_EhcNu4Vmx8HZW9', amount: '20000', description: 'Rails Stripe customer', currency: 'eur', transfer_data: {amount: 17000, destination: "acct_1EEDVbJ3MKDJIzxo"}
})

      @order.update(stripe_customer_id: charge[:customer], status: 1)
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