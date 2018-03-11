require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:transaction_params) { FactoryBot.attributes_for :transaction }
  describe 'POST create new transaction as logged user' do
    login_user

    it 'initialized a new instance of transaction after calling new' do
      get :new
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end

    it 'has a 200 status code after create' do
      post :create, params: {transaction: transaction_params}
      assert_redirected_to root_path
    end

    it 'redirects to new layout and shows failure notice without params' do
      expect { post :create }.to raise_error ActionController::ParameterMissing
    end
  end

  describe 'POST create new transaction as unlogged user' do
    it 'does not initialize a transaction not logged in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'has a 302 status code after create when unlogged' do
      post :create, params: {transaction: transaction_params}
      expect(response.status).to eq(302)
      assert_redirected_to new_user_session_path
    end
  end
end
