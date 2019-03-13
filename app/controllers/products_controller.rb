class ProductsController < ApplicationController

 
  def index
    @products=Product.all
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])

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

end
