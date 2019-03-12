class ProductsController < ApplicationController
 
  def index
    @products=Product.all
    @categories = Category.all
  end




  def show
  end

  def create
  end

  def new
  end

  def update
  end

  def destroy
  end
end
