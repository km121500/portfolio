FactoryBot.define do
  factory :event do
    user_id { "1" }
    title { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    place { Faker::Lorem.characters(number:5) }
    date { Faker::Lorem.characters(number:5) }
    image_id { Faker::Lorem.characters(number:20) }
  end
end