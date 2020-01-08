# frozen_string_literal: true

require 'spec_helper'
require 'shoulda/matchers'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Object.send(:remove_const, :ActiveRecord)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in prod mode') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs

  config.infer_spec_type_from_file_location!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :helper

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  config.include RedirectBack

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    # with.library :action_controller
    with.library :rails
  end
end
