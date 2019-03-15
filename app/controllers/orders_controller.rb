class OrdersController < ApplicationController
  
  before_action :authenticate_user! 

  def new
  end

  def edit
  end

  def create
  	@order = Order.create(user_id: current_user.id, product_id: params[:product], status:1)

  	puts @order
  	redirect_to order_path(@order)
  end

  def update 
  end

  def show
	@order = Order.find(params[:id])
  end

end
