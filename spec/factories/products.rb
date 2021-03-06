FactoryBot.define do
  factory :product do
    title { Faker::Lorem.words }
    price { rand(1..1000) }
    description { Faker::Lorem.paragraph(2) }
    brand { Faker::Company.name }
    color { Faker::Color.color_name }
    state { 1 }
    condition { rand(1..5) }
    size { FactoryBot.create(:size) }
    seller { FactoryBot.create(:user) }
    category { FactoryBot.create(:category) }
  end
end
