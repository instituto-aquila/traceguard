FactoryBot.define do
  factory :application do
    sequence(:name) { |n| "Application #{n}" }
    api_key { SecureRandom.hex(20) }
  end
end
