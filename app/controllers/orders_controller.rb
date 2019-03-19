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

  	@order.update(notation:2, status: 3)
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
  	@disputed_orders = Order.where(user: current_user, status: 4)
  end

end
