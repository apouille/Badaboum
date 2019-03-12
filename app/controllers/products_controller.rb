class ProductsController < ApplicationController
  def index
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
    #@product.product_picture.attach(params[:product_picture])

    if @product.save
      redirect_to root_path, 
      flash[:success] = "Le produit est bien enregistré!"
    else
      render 'new'
    end
  end

  def destroy
  end
end
