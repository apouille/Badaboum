FactoryBot.define do
  factory :child do
    nickname { "pitchoune" }
    birthday { "2017-03-12" }
    sex { 1 }
    profile { FactoryBot.create(:profile)}
  end
end
