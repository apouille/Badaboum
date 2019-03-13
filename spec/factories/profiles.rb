FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "0033#{rand(100000000..999999999)}" }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    zip_code { "75000" }
    country { "France" }
    description { Faker::ChuckNorris.fact }
    user { FactoryBot.create(:user) }
  end
end
