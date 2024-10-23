FactoryBot.define do
  factory :user_monitoring do
    association :user
    association :application
    date { Faker::Date.backward(days: 14) }
  end
end