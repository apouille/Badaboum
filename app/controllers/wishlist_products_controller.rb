class WishlistProductsController < ApplicationController

  before_action :authenticate_user!

  def index
    @wishlist_products = WishlistProduct.where(user: current_user).all
    @wishlist_products_in_stock = in_stock
    @profile = current_user.profile
    @children = Child.where(profile_id: @profile.id)
  end

  def show
  end

  def create
    @product = Product.find(params[:product])
    @wishlist_product = WishlistProduct.create(user: current_user, product: @product)

   if @wishlist_product.save
     respond_to do |format|
       flash[:notice] = "Produit ajouté à votre Babylist"
       format.html {redirect_back fallback_location: products_path}
       format.js
     end
   end

  end

  def update
  end

  def new
  end


  def destroy
    @product = Product.find(params[:product])
    @wishlist_product = WishlistProduct.find(params[:id])
    @wishlist_product.destroy
     respond_to do |format|
       flash[:notice] = "Produit retiré de votre Babylist"
       format.html {redirect_back fallback_location: products_path}
       format.js
     end
  end

  private

    def in_stock
      wish_in_stocks = []
      WishlistProduct.where(user: current_user).all.each do |wp|
        if (wp.product.state == 'in_stock')
          wish_in_stocks << wp
        end
      end
      return wish_in_stocks
    end

end
