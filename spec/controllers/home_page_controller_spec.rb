require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  describe 'GET show unlogged' do
    it 'redirects to login page when unlogged' do
      get :show
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET show logged in' do
    login_user

    it 'has a 200 status code' do
      get :show
      expect(response.status).to eq(200)
    end
  end
end
