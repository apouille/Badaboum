class ProductsController < ApplicationController

before_action :authenticate_user! , only: [:new, :edit, :delete]

  def index
    puts "*" * 30
    puts params
    puts "*" * 30
    if !params[:category].present?
      @products = Product.all.in_stock.page(params[:page]).per(18)
    else
      @current_category = params[:category]
      @brand_array = Product.brand_array(@current_category)
      @nested_array_of_cat = Category.nested_array_of_cat
      @categories = Category.all
      @category = Category.find_by(id: params[:category])


      @products = Product.where(nil)
      @products = @products.in_stock
      @products = @products.cat(@current_category) if @current_category.present?
      @products = @products.price(params[:price]) if params[:price].present?
      @products = @products.brand(params[:brand]) if params[:brand].present?
      @products = @products.siz(size_params[:size_id]) if params[:size].present? && !size_params[:size_id].empty?
      @products = @products.page(params[:page]).per(9)
    end
  end

  def show
    @product = Product.find(params[:id])
    @seller_profile = @product.seller.profile
    @seller_products = @product.seller.uploaded_products.order(created_at: :desc)
    @comment = Comment.new

  end

  def new
    @product = Product.new
    @sizes = Size.all
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @sizes = Size.all

    @category_id = params[:category]
    @size_id = params[:size]

    @product = Product.new(
      title: params[:title],
      description: params[:description],
      price: params[:price],
      brand: params[:brand],
      color: params[:color],
      condition: params[:condition].to_i,
      size_id: @size_id,
      seller_id: current_user.id,
      category_id: @category_id,
      state: 1
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
    @category_id = params[:category]
    @size_id = params[:size]

    if @product.update(title: params[:title],
                       description: params[:description],
                       price: params[:price],
                       brand: params[:brand],
                       color: params[:color],
                       condition: params[:condition].to_i,
                       size_id: @size_id,
                       category_id: @category_id)

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

  private

  def size_params
      params.require(:size).permit(:size_id) if params[:size].present?
  end

end
