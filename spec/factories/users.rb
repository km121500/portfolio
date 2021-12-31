FactoryBot.define do
  factory :user do
    title { Faker::Name.name.characters(number:5) }
    title { Faker::Internet.email.characters(number:10) }
  end
end