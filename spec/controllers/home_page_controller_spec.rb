require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  describe 'GET show' do
    it 'has a 200 status code' do
      get :show
      expect(response.status).to eq(200)
    end
  end
end
