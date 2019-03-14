class ProductsController < ApplicationController


  def index
    @products=Product.all
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
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
    puts "*"*100
    puts params
    puts "*"*100
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

end
