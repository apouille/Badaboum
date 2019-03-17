FactoryBot.define do
  factory :user do
    password { SecureRandom.urlsafe_base64 }
    email { Faker::Internet.email }  
  end
end
