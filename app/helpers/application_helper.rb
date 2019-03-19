module ApplicationHelper
	
	def bootstrap_class_for_flash(type)
  case type
    when 'notice' then "alert-info"
    when 'success' then "alert-success"
    when 'error' then "alert-danger"
    when 'alert' then "alert-warning"
  end
end

def ip_address
   @current_ip_address = request.ip     # return your ip address
end

def geoloc_user
	@results = Geocoder.search(current_ip_address)
end

def location
@location =adrrequest.location     # return a Geocoder::Result which corresponds to your location
end


def find_city
 @user_city = request.location.try(:city) # return the city corresponding to your ip location
end

def sortable(column, title = nil)
  title ||= column.titleize
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction}
end


end