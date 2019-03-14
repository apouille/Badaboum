FactoryBot.define do
  factory :order do
    status { 1 }
    stripe_customer_id { "MyString" }
  end
end
