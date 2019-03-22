class HomeController < ApplicationController
  def index
    @products = Product.all.in_stock.order(created_at: :desc)

    #current_ip_address = '195.154.25.0'    # return your ip address
 	#results = Geocoder.search(current_ip_address)
 	puts '$'*100
	# puts results.first.coordinates
	puts '$'*100
	# puts results.first.country
	puts '$'*100
	# puts @close_profile = Profile.near("1 rue du caire 75002 Paris", 1)

 #@close_profile = Location.near([current_user.latitude, current_user.longitude], 50, :order => :distance)

 end


  def kitui
  end

  def 
  end
end
