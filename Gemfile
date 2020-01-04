source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootstrap', '~> 4.4', '>= 4.4.1'

gem 'groupdate', '~> 4.2'
gem 'active_median'
gem 'chartkick', '~> 3.3'

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'semantic-ui-sass', '~> 2.4', '>= 2.4.2.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.5'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'haml-rails'

gem 'fog-aws', '~> 3.5', '>= 3.5.2'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'mongoid', '~> 7.0', '>= 7.0.5'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'kaminari-mongoid', '~> 1.0', '>= 1.0.1'
gem 'bson_ext'
gem 'json'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem "mongoid-grid_fs"
gem 'mini_magick'
gem 'omniauth', '~> 1.9'
gem 'omniauth-facebook'
gem 'pundit'
gem 'paranoia', '~> 2.4', '>= 2.4.2'
gem 'mongoid_paranoia', '~> 0.4.0'
gem 'chosen-rails', '~> 1.9'
gem 'ffaker', '~> 2.13'

group :development, :test do
  gem 'rspec', '~> 3.9'
  gem 'rspec-rails', '~> 3.9'
  gem 'rails-controller-testing'
  gem 'letter_opener', '~> 1.7'
  gem 'rubocop', '~> 0.72.0'
  gem 'rubocop-rspec'
  gem 'mongoid-rspec'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'ffaker', '~> 2.13'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  # Adds support for Capybara system testing and selenium driver
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  # gem 'cucumber', '~> 3.1', '>= 3.1.2'
  # gem 'cucumber-rails', '~> 2.0', require: false
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
