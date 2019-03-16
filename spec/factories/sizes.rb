FactoryBot.define do
  factory :size do
    title { Faker::Alphanumeric.alphanumeric 10 }
  end
end
