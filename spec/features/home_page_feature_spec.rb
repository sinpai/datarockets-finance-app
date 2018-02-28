# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home page content', type: :feature do
  let(:user) { create :user }

  scenario 'Check correct redirect' do
    visit '/'
    expect(page).to have_content 'You should be logged in order to see this page'
  end

  scenario 'Log in' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end
end
