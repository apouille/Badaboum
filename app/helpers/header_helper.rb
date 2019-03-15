module HeaderHelper
	def categories
		@categories = Category.all
	end
end