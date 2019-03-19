class OrdersController < ApplicationController
  
  before_action :authenticate_user! 

  before_action :notation, only: [:update]


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
  	@order.update(notation:2, status: @status)
  	redirect_to orders_path

  end

  def show
	@order = Order.find(params[:id])
	@product =@order.product
	@profile = current_user.profile
	@seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
  end

  def index
  	@orders = Order.where(user: current_user)
  	@paid_orders = Order.where(user: current_user, status: 2)
  	@completed_orders = Order.where(user: current_user, status: 3)
  	@disputed_orders = Order.where(user: current_user, status: 4).or(Order.where(user: current_user, status: 5))

  	@refunded_orders = Order.where(user: current_user, status: 5)
  end


	private
	def notation
		@order=Order.find(params[:id])
		unless @order.notation !=nil
		flash[:error] = "Vous devez noter le vendeur avant de clôturer la transaction"
		@order.update(status: 2)
		end 
	end
end
