FactoryBot.define do
  factory :product do
  	title { Faker::Lorem.words(1) }
    price { rand(1..1000) }
    description { Faker::Lorem.paragraph(2) }
    brand { Faker::Company.name }
    color { Faker::Color.color_name }
    size { 12 }
    seller { FactoryBot.create(:user)}
    category { FactoryBot.create(:category)}
  end
end
