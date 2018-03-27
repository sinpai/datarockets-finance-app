require 'rails_helper'

RSpec.describe 'Signup with social accounts', type: :feature do
  context 'when signing up with Github' do
    before { stub_omniauth_provider('github') }

    it 'creates user' do
      visit '/users/sign_in'
      click_link('Sign in with Github')
      page.should have_content('Successfully authenticated from social account.')
    end
  end

  context 'when signing up with google' do
    before { stub_omniauth_provider('google') }

    it 'creates user' do
      visit '/users/sign_in'
      click_link('Sign in with Google')
      page.should have_content('Successfully authenticated from social account.')
    end
  end
end
