class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = Order.create(user_id: current_user.id, product_id: Product.find(1).id, status: 1)
    @amount = 1000
    @profile_current_user = current_user.profile

    percentage = @amount * 0.05

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )


    begin
  #    charge = Stripe::Charge.create({ customer: 'cus_EhcNu4Vmx8HZW9', 
   #   	amount: '1337', description: 'Rails Stripe customer', currency: 'eur', 
   #   	application_fee_amount: 2, on_behalf_of: "acct_1EEDVbJ3MKDJIzxo"})
 #	charge = Stripe::Charge.create({ customer: 'cus_EhcNu4Vmx8HZW9', amount: '20000', description: 'Rails Stripe customer', currency: 'eur', on_behalf_of: "acct_1EEDVbJ3MKDJIzxo"})
	charge = Stripe::Charge.create({ customer: 'cus_EhcNu4Vmx8HZW9', amount: '20000', 
		description: 'Rails Stripe customer', currency: 'eur', transfer_data: {
	amount: 17000,
    destination: "acct_1EEDVbJ3MKDJIzxo",
  },
})

      @order.update(stripe_customer_id: charge[:customer], status: 1)
      puts charge
      flash[:notice] = 'Your order is complete'
      redirect_to root_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    rescue Stripe::InvalidRequestError => e
      p 'ALERT CODE RED PLEASE GO BURN THIS SHITTY SERVICE'
      p e
    end
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