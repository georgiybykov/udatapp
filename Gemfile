# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.5'

gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.3'

gem 'bootsnap', '>= 1.4.4', require: false

gem 'dry-auto_inject', '~> 0.9'
gem 'dry-container', '~> 0.9'
gem 'dry-monads', '~> 1.4'
gem 'dry-validation', '~> 1.8'

gem 'surrealist', '~> 2.0'

gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'

  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rswag-specs'

  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'yard'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 5.1'
end

group :development do
  gem 'listen', '~> 3.3'

  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
