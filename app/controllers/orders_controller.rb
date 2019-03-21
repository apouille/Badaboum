class OrdersController < ApplicationController
  
  before_action :authenticate_user! 

  def new
  end

  def edit
  end

  def create
  	@order = Order.create(user_id: current_user.id, product_id: params[:product], status:1, notation:2)

  	puts @order
  	redirect_to order_path(@order)
  end

  def update 

  	@order=Order.find(params[:id])
  	@status = params[:status]
  	@notation = params[:notation]

  	#Variable pour le paiment stripe
  	@product =@order.product
  	@amount = @order.product.price*100
  	@application_fee_amount = (@amount*0.1).to_i
  	@seller_uid = @order.product.seller.stripe_uid
    customer = @order.stripe_customer_id
    
   	#Cas ou l'acheteur valide la vente et note le vendeur
  	if params[:status] == 'completed'
  		charge = Stripe::Charge.create({ currency: 'eur', customer: customer, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', currency: 'eur', transfer_data: {destination: @seller_uid}
	})
  		@order.update(notation: @notation, status: @status)
  		@product.update(state:2)


  		#Je déclenche les notifications mails
  		confirmation_buyer_transaction(@order.user)
  		confirmation_seller_transaction(@order.product.seller)

		flash[:success] = "Merci. Votre commande est validée et le montant vient d'être débité de votre compte"
		redirect_to orders_path
	
	#Cas ou le vendeur accepte l'annulation de la resrvation
	elsif params[:status] == 'refunded'
		@order.update(status: @status)
		@product.update(state:1)
		flash[:success] = "l'annulation de la réservation a bien été prise en compte. Votre produit est à nouveau disponible à la vente"
		redirect_to orders_path

	#cas ou l'acheteur demande l'annulation de sa réservation
	else
		@order.update(status: @status)
		flash[:success] = "Merci. Votre demande d'annulation a bien été prise en compte. "
		redirect_to orders_path
	end
  end

  def show
	@order = Order.find(params[:id])
	@product =@order.product
	@profile = current_user.profile
	@seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
  end


  def index
  	#variables pour l'acheteur
  	@orders = Order.where(user: current_user)
  	@paid_orders = Order.where(user: current_user, status: 2)
  	@completed_orders = Order.where(user: current_user, status: 3)
  	@disputed_orders = Order.where(user: current_user, status: 4).or(Order.where(user: current_user, status: 5))
  	@refunded_orders = Order.where(user: current_user, status: 5)

  	#Variables pour le vendeur
  	@seller_reservations = my_reservations(current_user)
 	@seller_sales = my_sales(current_user)
    @seller_cancelled_sales = my_cancelled_sales(current_user)
  	@seller_refunded_sales = my_refunded_sales(current_user)
  end


	private

	def my_reservations(user)
		my_reservations = []
		reserved_orders=Order.where(status: 2)
		reserved_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_reservations << order
			end
		end
		return my_reservations	
	end


	def my_sales(user)
		my_sales = []
		selled_orders=Order.where(status: 3)
		selled_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_sales << order
			end
		end
		return my_sales	
	end

	def my_cancelled_sales(user)
		my_cancelled_sales = []
		cancelled_orders=Order.where(status: 4)
		cancelled_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_cancelled_sales << order
			end
		end
		return my_cancelled_sales	
	end

	def my_refunded_sales(user)
		my_refunded_sales = []
		refunded_orders=Order.where(status: 5)
		refunded_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_refunded_sales << order
			end
		end
		return my_refunded_sales
	end


   def confirmation_buyer_transaction(buyer)
     UserMailer.confirmation_buyer_transaction(buyer).deliver_now
   end

   def confirmation_seller_transaction(seller)
     SellerMailer.confirmation_seller_transaction(seller).deliver_now
   end


end
