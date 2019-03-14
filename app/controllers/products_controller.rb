class ProductsController < ApplicationController


  def index
    @products=Product.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
  end

  def new
  	@product = Product.new
  	@categories = Category.all
  end

  def create
  	@categories = Category.all
  	@product = Product.new(title: params[:title],
                       description: params[:description],
                       price: params[:price],
                       brand: params[:brand],
                       color: params[:color],
                       size: params[:size],
                       seller_id: current_user.id,
                       category_id: params[:category],
                       )
    @product.pictures.attach(params[:pictures])

    if @product.save
      redirect_to root_path
      flash[:success] = "Le produit est bien enregistré!"
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    flash[:notice] = "Vous avez supprimé un article avec succès"
    redirect_to profile_path
  end

  def from_category
    @selected = Product.where(:category_id => params[:cat_id])
    respond_to do |format|
      format.js
    end
  end

end
