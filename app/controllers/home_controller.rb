class HomeController < ApplicationController

  def index
    @products = Product.all.in_stock.order(created_at: :desc)
  end

  def team
  end
end
