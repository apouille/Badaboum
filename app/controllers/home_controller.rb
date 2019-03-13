class HomeController < ApplicationController
  def index
    @products = Product.last(6)
  end

  def kitui
  end
end
