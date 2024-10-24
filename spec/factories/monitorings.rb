# spec/factories/monitorings.rb
FactoryBot.define do
  factory :monitoring do
    application
    date { Faker::Time.backward(days: 14, period: :all) }
    user { { name: Faker::Name.name, email: Faker::Internet.email, ip: Faker::Internet.ip_v4_address } }
    pages_visited { [{ page_url: Faker::Internet.url, start_time: Faker::Time.backward(days: 14, period: :all), end_time: Faker::Time.backward(days: 14, period: :all), duration_seconds: Faker::Number.between(from: 1, to: 3600), publication_id: Faker::Number.between(from: 1, to: 100), publication_title: Faker::Lorem.sentence }] }
  end
end