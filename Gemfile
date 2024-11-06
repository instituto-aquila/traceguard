source "https://rubygems.org"

gem "rails", "~> 7.2.1", ">= 7.2.1.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem 'sidekiq', '~> 7.3', '>= 7.3.2'
gem 'redis', '~> 5.3'
gem 'jwt', '~> 2.9', '>= 2.9.3'
gem 'rack-cors', '~> 2.0', '>= 2.0.2'
gem 'rswag', '~> 2.15'
gem 'active_model_serializers', '~> 0.10.14'
gem 'blueprinter', '~> 1.1', '>= 1.1.2'
gem 'oj', '~> 3.16', '>= 3.16.6'
gem 'rack-attack', '~> 6.7'

gem 'will_paginate', '~> 3.3'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'rspec-rails', '~> 7.0', '>= 7.0.1'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'faker', '~> 3.5', '>= 3.5.1'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.2'
  gem 'shoulda-matchers', '~> 6.4'
  gem 'rubocop', '~> 1.67'
  gem 'brakeman', '~> 6.2', '>= 6.2.2'
  gem 'dotenv-rails', '~> 3.1', '>= 3.1.4'
end


