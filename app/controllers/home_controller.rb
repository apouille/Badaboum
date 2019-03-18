class HomeController < ApplicationController
  def index
    @products = Product.order(created_at: :desc)
    puts @current_ip_address = request.ip     # return your ip address
 
end


  def kitui
  end

  def team
  end
end
