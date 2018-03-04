# frozen_string_literal: true

require 'devise/orm/active_record'

Devise.setup do |config|
  config.secret_key = ENV['DEVISE_SECRET_KEY']
  config.mailer_sender = 'df@datarockets-finance.herokuapp.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :google_oauth2, ENV['GOOGLE_OAUTH_ID'], ENV['GOOGLE_OAUTH_SECRET']
  config.omniauth :github, ENV['GITHUB_OAUTH_ID'], ENV['GITHUB_OAUTH_SECRET'], scope: 'user:email'
end
