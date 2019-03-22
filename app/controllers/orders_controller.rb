class OrdersController < ApplicationController
  
  before_action :authenticate_user! 

  def new
  end

  def edit
  end

  def create
  	@order = Order.create(user_id: current_user.id, product_id: params[:product], status: 'cart', notation:2)
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
  	if params[:status] == 'confirmation'

  		#Je déclenche paiement stripe
  		charge = Stripe::Charge.create({ currency: 'eur', customer: customer, amount: @amount, application_fee_amount: @application_fee_amount, description: 'Rails Stripe customer', transfer_data: {destination: @seller_uid}
		})

  		#Je mets à jour mes status
  		@order.update(notation: @notation, status: @status)
  		@product.update(state: 'sold')

  		#Je déclenche les notifications mails
  		confirmation_buyer_transaction(@order.user)
  		confirmation_seller_transaction(@order.product.seller)

		flash[:success] = "Merci. Votre commande est validée et le montant vient d'être débité de votre compte"
		redirect_to orders_path

	#cas où l'acheteur demande l'annulation de sa réservation
	elsif params[:status] == 'cancellation_request'
		
		#Je mets à jour mes status
		@order.update(status: @status)
		@product.update(state: 'sold')

		#Je déclenche les notifications mails
		confirmation_buyer_cancellation(@order.user)
  		confirmation_seller_cancellation(@order.product.seller)

		flash[:success] = "Merci. Votre demande d'annulation a bien été prise en compte. "
		redirect_to orders_path
	
	#Cas où le vendeur déclenche ou accepte l'annulation de la reservation
	elsif params[:status] == 'cancellation'
		
		#Je mets à jour mes status
		@order.update(status: @status)
		@product.update(state: 'in_stock')

		#Je déclenche les notifications mails
		confirmation_buyer_refund(@order.user)
  		confirmation_seller_refund(@order.product.seller)

		flash[:success] = "l'annulation de la réservation a bien été prise en compte. Votre produit est à nouveau disponible à la vente"
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
  	@buyer_reservations = Order.where(user: current_user, status: 2)
  	@buyer_confirmations = Order.where(user: current_user, status: 3)
  	@buyer_cancellation_requests = Order.where(user: current_user, status: 4)
  	@buyer_cancellations = Order.where(user: current_user, status: 5)
  	@buyer_disputes =Order.where(user: current_user, status: 6)

  	#Variables pour le vendeur
  	@seller_reservations = my_reservations(current_user)
 	@seller_confirmations = my_confirmations(current_user)
    @seller_cancellation_requests = my_cancellation_requests(current_user)
  	@seller_cancellations = my_cancellations(current_user)
  	@seller_disputes = my_disputes(current_user)

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


	def my_confirmations(user)
		my_confirmations = []
		confirmed_orders=Order.where(status: 3)
		confirmed_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_confirmations << order
			end
		end
		return my_confirmations	
	end

	def my_cancellation_requests(user)
		my_cancellation_requests = []
		cancelled_requests=Order.where(status: 4)
		cancelled_requests.each do |order|
			if (order.product.seller.id == user.id) 
				my_cancellation_requests << order
			end
		end
		return my_cancellation_requests	
	end

	def my_cancellations(user)
		my_cancellations = []
		cancelled_orders=Order.where(status: 5)
		cancelled_orders.each do |order|
			if (order.product.seller.id == user.id) 
				my_cancellations << order
			end
		end
		return my_cancellations
	end

	def my_disputes(user)
		my_disputes = []
		disputes = Order.where(status: 6)
		disputes.each do |order|
			if (order.product.seller.id == user.id) 
				my_disputes << order
			end
		end
		return my_disputes
	end


   def confirmation_buyer_transaction(buyer)
     UserMailer.confirmation_buyer_transaction(buyer).deliver_now
   end

   def confirmation_seller_transaction(seller)
     SellerMailer.confirmation_seller_transaction(seller).deliver_now
   end


   def confirmation_buyer_cancellation(buyer)
   	UserMailer.confirmation_buyer_cancellation(buyer).deliver_now
   end

   def confirmation_seller_cancellation(seller)
   	SellerMailer.confirmation_seller_cancellation(seller).deliver_now
	end

	   def confirmation_buyer_refund(buyer)
   	UserMailer.confirmation_buyer_refund(buyer).deliver_now
   end

   def confirmation_seller_refund(seller)
   	SellerMailer.confirmation_seller_refund(seller).deliver_now
	end

end
