require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:transaction_params) { attributes_for :transaction }
  let(:test_transaction) { create :transaction }

  context 'when logged in' do
    login_user

    describe 'GET #index' do
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    describe 'GET #search' do
      it 'has a 200 status code' do
        get :search
        expect(response.status).to eq(200)
      end
    end
  end

  context 'when logged out' do
    describe 'GET #index' do
      before do
        get :index
      end

      it 'has a 302 status code' do
        expect(response.status).to eq(302)
      end

      it 'redirects to a new user session' do
        assert_redirected_to new_user_session_path
      end
    end

    describe 'GET #search' do
      before do
        get :search
      end

      it 'has a 302 status code' do
        expect(response.status).to eq(302)
      end

      it 'redirects to a new user session' do
        assert_redirected_to new_user_session_path
      end
    end
  end
end
