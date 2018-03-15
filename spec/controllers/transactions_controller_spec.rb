require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:transaction_params) { FactoryBot.attributes_for :transaction }
  let!(:test_transaction) { FactoryBot.create :transaction }

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

    context 'and during edit transaction' do
      it 'returns correct transaction' do
        get :edit, params: {id: test_transaction.id}
        expect(assigns(:transaction)).to eq(test_transaction)
      end
    end

    context 'dealing with new sum and comment' do
      let(:rand_num) { Faker::Number.digit }
      let(:new_comment) { Faker::Lorem.sentence }
      let(:params) do
        {
          id: test_transaction.id,
          transaction: {
            id: test_transaction.id,
            sum: rand_num,
            comment: new_comment
          }
        }
      end

      before { put :update, params: params }

      it 'updates transaction' do
        test_transaction.reload
        expect(test_transaction.sum).to eq rand_num.to_i
        expect(test_transaction.comment).to eq new_comment
      end
    end

    context 'dealing with incorrect sum' do
      let(:new_comment) { Faker::Lorem.sentence }
      let(:params) do
        {
          id: test_transaction.id,
          transaction: {
            id: test_transaction.id,
            sum: new_comment,
            comment: new_comment
          }
        }
      end

      before { put :update, params: params }

      it 'updates transaction' do
        test_transaction.reload
        expect(test_transaction.sum).not_to eq new_comment
      end
    end

    context 'and after destroying transaction' do
      it 'destroys transaction properly' do
        expect { delete :destroy, params: {id: test_transaction.id} }
          .to change(Transaction, :count).by(-1)
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
