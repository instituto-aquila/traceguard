FactoryBot.define do
  factory :status do
    name { Faker::Lorem.word }
    color { Faker::Color.hex_color }
  end
end