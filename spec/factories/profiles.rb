FactoryBot.define do
  factory :profile do
    user { FactoryBot.create(:user) }
  end
end
