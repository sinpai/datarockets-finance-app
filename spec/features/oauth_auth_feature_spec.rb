require 'rails_helper'

RSpec.describe 'Signup with social accounts', type: :feature do
  context 'when signing up with Github' do
    before { stub_omniauth_provider('github') }

    it 'visit sign up' do
      expect do
        visit '/users/sign_in'
        click_link('Sign in with Github')
      end.to change(User, :count).by(1)
    end
  end

  context 'when signing up with Google' do
    before { stub_omniauth_provider('google_oauth2') }

    it 'visit sign up' do
      expect do
        visit '/users/sign_in'
        click_link('Sign in with Google Oauth2')
      end.to change(User, :count).by(1)
    end
  end
end
