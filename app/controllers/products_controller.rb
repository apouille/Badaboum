class ProductsController < ApplicationController

before_action :authenticate_user! , only: [:new, :edit, :delete]

  def index
    @products = Product.where(nil)
    @products = @products.cat(params[:category]) if params[:category].present?
    @products = @products.page(params[:page]).per(9)
    
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
    @comment = Comment.new
    @profile = current_user.profile
  end

  def new
    @product = Product.new
    @sizes = Size.all
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @sizes = Size.all
    @product = Product.new(title: params[:title],
                       description: params[:description],
                       price: params[:price],
                       brand: params[:brand],
                       color: params[:color],
                       size_id: params[:size],
                       seller_id: current_user.id,
                       category_id: params[:category],
                       status: 1
                       )
    @product.pictures.attach(params[:pictures])

    if @product.save
      redirect_to root_path
      flash[:success] = "L'article #{@product.title} est bien enregistré!"
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all
    @sizes = Size.all
    @product = Product.find(params[:id])
  end

  def update
    @categories = Category.all
    @sizes = Size.all
    @product = Product.find(params[:id])

    if @product.update(title: params[:title],
                       description: params[:description],
                       price: params[:price],
                       brand: params[:brand],
                       color: params[:color],
                       size_id: params[:size],
                       category_id: params[:category])
      
      redirect_to root_path
      flash[:success] = "L'article #{@product.title} à bien été mis-à-jour"
    else
      render 'new'
    end
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
