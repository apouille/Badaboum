class Category < ApplicationRecord
	has_many :products

	validates :title, presence: true
	validates :icon, presence: true

  def self.nested_array_of_cat
    nested_array = []
    cat_array = []

    self.all.each do |category|
      cat_array = [category.title, category.id]
      nested_array << cat_array
    end
    return nested_array
  end 

end
