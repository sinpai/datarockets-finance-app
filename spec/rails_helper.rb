require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'support/factory_bot'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require_relative 'support/controller_macros'

OmniAuth.config.test_mode = true
omniauth_hash = {'provider' => 'github',
                 'uid' => '12345',
                 'info' => {
                   'name' => 'test',
                   'email' => 'test@github.com',
                   'nickname' => 'test'
                 },
                 'extra' => {
                   'raw_info' => {
                     'location' => 'San Francisco',
                     'gravatar_id' => '123456789'
                   }
                 }}

OmniAuth.config.add_mock(:github, omniauth_hash)

require 'capybara/rspec'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
