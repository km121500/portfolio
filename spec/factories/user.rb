FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { 12_345_678_909 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
