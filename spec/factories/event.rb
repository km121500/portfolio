FactoryBot.define do
  factory :event do
    body { Faker::Lorem.characters(number: 20) }
    user
  end
end
