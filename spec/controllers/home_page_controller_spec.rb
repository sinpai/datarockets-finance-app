# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  describe 'GET show' do
    login_user

    it 'has a 200 status code' do
      get :show
      expect(response.status).to eq(200)
    end
  end
end
