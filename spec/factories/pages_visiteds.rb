FactoryBot.define do
  factory :pages_visited do
    page_url { Faker::Internet.url }
    start_time { Faker::Time.backward(days: 14, period: :all) }
    end_time { Faker::Time.backward(days: 14, period: :all) }
    duration_seconds { Faker::Number.between(from: 1, to: 3600) }
    publication_id { Faker::Number.between(from: 1, to: 100) }
    publication_title { Faker::Lorem.sentence }
    association :user_monitoring
  end
end