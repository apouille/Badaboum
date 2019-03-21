FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraph }
    conversation { FactoryBot.create(:conversation) }
    user { FactoryBot.create(:user) }
  end
end
