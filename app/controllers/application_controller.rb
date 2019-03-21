class ApplicationController < ActionController::Base
	include WishlistProductsHelper
	include HeaderHelper
  include ConversationsHelper
  include MessagesHelper
end
