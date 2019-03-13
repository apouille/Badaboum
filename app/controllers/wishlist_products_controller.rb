class WishlistProductsController < ApplicationController

  before_action :authenticate_user!

  def index
    @wishlist_products = WishlistProduct.where(user: current_user).all
    puts @wishlist_products
  end

  def show
  end

  def create
    @product = Product.find(params[:product])
    @wishlist_product = WishlistProduct.create(user: current_user, product: @product)

   

  end

  def update
  end

  def new
  end

 
  def destroy
    @wishlist_product = WishlistProduct.find(params[:id])
    @wishlist_product.destroy
  end


end
