FactoryBot.define do
  factory :conversation do
    sender { FactoryBot.create(:user) }
    recipient { FactoryBot.create(:user) }
  end
end
