require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:transaction_params) { FactoryBot.attributes_for :transaction }

  context 'when logged in' do
    login_user

    context 'and after transaction initialized' do
      it 'does not initialize a transaction not logged in' do
        get :new
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end
    end

    context 'and after transaction creation' do
      before do
        post :create, params: {transaction: transaction_params}
      end

      it 'has a 302 status code' do
        expect(response.status).to eq(302)
      end

      it 'redirects to a activity page' do
        assert_redirected_to root_path
      end

      it 'redirects to new layout and shows failure notice without params' do
        expect { post :create }.to raise_error ActionController::ParameterMissing
      end
    end
  end

  context 'when logged out' do
    context 'and after transaction initialized' do
      it 'does not initialize a transaction not logged in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'and after transaction creation' do
      before do
        post :create, params: {transaction: transaction_params}
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
