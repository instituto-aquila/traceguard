FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    ip { Faker::Internet.ip_v4_address }
  end
end