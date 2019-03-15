FactoryBot.define do
  factory :child do
    nickname { Faker::Superhero.name }
    birthday { Faker::Date.backward(14) }
    sex { rand(1..2) }
    profile { FactoryBot.create(:profile) }
  end
end
