FactoryBot.define do
  factory :order do
    status { rand(1..2) }
    stripe_customer_id { Faker::Alphanumeric.alphanumeric 20 }
    user { FactoryBot.create(:user) }
    product { FactoryBot.create(:product) }
  end
end
