FactoryBot.define do
  factory :product do
    price { 1 }
    description { "MyText" }
    brand { "MyString" }
    color { "MyString" }
    size { 1 }
  end
end
