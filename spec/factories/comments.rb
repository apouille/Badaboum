FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user { FactoryBot.create(:user) }
    product { FactoryBot.create(:product) }
  end
end
