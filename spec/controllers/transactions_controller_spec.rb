require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:transaction_params) { FactoryBot.attributes_for :transaction }
<<<<<<< HEAD
  let!(:test_transaction) { FactoryBot.create :transaction }

  describe 'logged in user' do
    login_user

    describe 'GET new transaction' do
      it 'initialized a new instance of transaction after calling new' do
        get :new
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end
    end

    describe 'POST create transaction' do
      it 'has a 200 status code after create' do
        post :create, params: {transaction: transaction_params}
        assert_redirected_to root_path
      end

      it 'redirects to new layout and shows failure notice without params' do
        expect { post :create }.to raise_error ActionController::ParameterMissing
      end
    end

    describe 'GET edit transaction' do
      it 'returns correct transaction' do
        get :edit, params: {id: test_transaction.id}
        expect(assigns(:transaction)).to eq(test_transaction)
      end
    end

    describe 'PUT update transaction' do
      it 'updates transaction with new sum and comment' do
        rand_num = rand(1000)
        put :update, params: {id: test_transaction.id,
                              transaction: {
                                id: test_transaction.id,
                                sum: rand_num,
                                comment: 'Updated comment'
                              }}
        test_transaction.reload
        expect(test_transaction.sum).to eq(rand_num)
        expect(test_transaction.comment).to eq('Updated comment')
      end

      it 'updates transaction with incorrect params sum and comment' do
        put :update, params: {id: test_transaction.id,
                              transaction: {
                                id: test_transaction.id,
                                sum: 'Updated comment'
                              }}
        test_transaction.reload
        expect(test_transaction.sum).not_to eq('Updated comment')
      end
    end

    describe 'DELETE destroy transaction' do
      it 'destroys transaction' do
        expect { delete :destroy, params: {id: test_transaction.id} }
          .to change(Transaction, :count).by(-1)
=======

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
>>>>>>> 854e57d88dad3173c28feb9f0cae7a86d0b05f1f
      end
    end
  end

<<<<<<< HEAD
  describe 'unlogged user' do
    describe 'GET new transaction' do
=======
  context 'when logged out' do
    context 'and after transaction initialized' do
>>>>>>> 854e57d88dad3173c28feb9f0cae7a86d0b05f1f
      it 'does not initialize a transaction not logged in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

<<<<<<< HEAD
    describe 'POST create transaction' do
      it 'has a 302 status code after create when unlogged' do
        post :create, params: {transaction: transaction_params}
        expect(response.status).to eq(302)
=======
    context 'and after transaction creation' do
      before do
        post :create, params: {transaction: transaction_params}
      end

      it 'has a 302 status code' do
        expect(response.status).to eq(302)
      end

      it 'redirects to a new user session' do
>>>>>>> 854e57d88dad3173c28feb9f0cae7a86d0b05f1f
        assert_redirected_to new_user_session_path
      end
    end
  end
end
