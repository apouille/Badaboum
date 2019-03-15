FactoryBot.define do
  factory :category do
    title { Faker::Alphanumeric.alphanumeric 10 }
    icon { Faker::Alphanumeric.alphanumeric 10 }
  end
end
