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


   if @wishlist_product.save
     respond_to do |format|
       flash[:notice] = "produit ajouté à votre babylist" 
       format.html {redirect_back fallback_location: products_path}
       format.js 
     end
   

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
