# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
# A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'
# Ruby JSON Schema Validator
gem 'json-schema'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # irb alternative
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  # testing with rspec
  gem 'rspec-rails'
  # Setting up Ruby objects as test data
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails'
  # Code smells report
  gem 'reek'
end

group :test do
  # express expected outcomes on collections of an object in an example
  gem 'rspec-collection_matchers'
  # one liners for common rails functionality
  gem 'shoulda-matchers'
  # Code coverage
  gem 'simplecov', require: false
  # Library for stubbing and setting expectations on HTTP requests in Ruby
  gem 'webmock'
  # time travel in tests
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
