FactoryBot.define do
  factory :status do
    sequence(:name) { |n| "Status #{n}" }
    color { Faker::Color.hex_color }
  end
end