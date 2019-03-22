class ProductsController < ApplicationController

before_action :authenticate_user! , only: [:new, :edit, :delete]
before_action :mandatory_profile , only: [:new]

  def index
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
    @last_size = Size.last
    @categories = Category.all
    unless current_user.stripe_uid.present?
      redirect_to payment_profile_path
    end
  end

  def create
    @categories = Category.all
    @sizes = Size.all
    @last_size = Size.last

    @category_id = params[:category]
    @size_id = params[:size]
    @condition_id = params[:condition].to_i
    if @condition_id == 0
      @condition_id = nil
    end

    @product = Product.new(
      title: params[:title],
      description: params[:description],
      price: params[:price],
      brand: params[:brand],
      color: params[:color],
      condition: @condition_id,
      size_id: @size_id,
      seller_id: current_user.id,
      category_id: @category_id,
      state: 1
    )

    @product.pictures.attach(params[:pictures])

    if @product.save
      redirect_to request.referer
      flash[:success] = "L'article #{@product.title} est bien enregistré!"
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all
    @sizes = Size.all
    @product = Product.find(params[:id])
    @category = @product.category
    @last_size = Size.last
  end

  def update
    @categories = Category.all
    @sizes = Size.all
    @product = Product.find(params[:id])
    @category = @product.category
    @last_size = Size.last
    @size_id = params[:size]
    @condition_id = params[:condition].to_i
    if @condition_id == 0
      @condition_id = nil
    end

    if @product.update(title: params[:title],
                       description: params[:description],
                       price: params[:price],
                       brand: params[:brand],
                       color: params[:color],
                       condition: @condition_id,
                       size_id: @size_id)

      redirect_to profile_path
      flash[:success] = "L'article #{@product.title} à bien été mis-à-jour"
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.orders.present?
       @product.update(state: 'inactive')
    else
       @product.destroy
    end
    @product.wishlist_products.destroy
    @myproducts = current_user.uploaded_products.in_stock.order(created_at: :desc)
    respond_to do |format|
      format.js {render layout: false}
    end
    flash[:notice] = "Vous avez supprimé un article avec succès"
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

  def mandatory_profile
    unless current_user.profile.first_name.present?
      flash[:error] = "Vous devez compléter votre profil afin de proposer un produit à la vente."
      redirect_to edit_profile_path
    end
  end

end
