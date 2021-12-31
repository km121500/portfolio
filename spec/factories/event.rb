FactoryBot.define do
  factory :book do
    title { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    place { Faker::Lorem.characters(number:5) }
    date { Faker::Lorem.characters(number:5) }
    image { Faker::Lorem.characters(number:20) }
  end
end 