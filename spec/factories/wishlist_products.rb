FactoryBot.define do
  factory :wishlist_product do
    product { FactoryBot.create(:product) }
    user { FactoryBot.create(:user) }    
  end
end
