module CapybaraHelper
  Capybara.save_path = '/tmp'
  Capybara::Screenshot.autosave_on_failure = true
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 10
  Capybara.default_driver = :webkit
end
