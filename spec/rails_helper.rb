require 'spec_helper'
require 'require_all'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require_all 'spec/support/*.rb'

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Capybara.save_path = '/tmp'
  Capybara::Screenshot.autosave_on_failure = true
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 10
  Capybara.default_driver = :webkit

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include OmniauthHelper
  config.include FeatureTestsHelper
end
