# spec/factories/error_logs.rb
FactoryBot.define do
  factory :error_log do
    code { Faker::Number.between(from: 100, to: 599) }
    erro { Faker::Lorem.sentence }
    backtrace { Faker::Lorem.paragraph }
    date { Faker::Time.backward(days: 14, period: :all) }
    url { Faker::Internet.url }
    http_method { %w[GET POST PUT DELETE PATCH].sample }
    association :application
    association :status
    association :user
  end
end