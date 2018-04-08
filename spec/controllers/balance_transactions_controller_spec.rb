require 'rails_helper'

RSpec.describe BalanceTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, :balance_transactions, user: user) }

  login_user

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'renders the :edit template' do
      get :edit, params: {id: transaction.transactinable.id}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:user) { create(:user) }

      let(:attributes) do
        attributes_for(:balance_transaction, transactions_attributes: attributes_for(:transaction))
      end

      it 'redirects after create' do
        post :create, params: {balance_transaction: attributes}
        expect(response).to redirect_to transactions_path
      end
    end

    context 'when not valid' do
      let(:attributes) do
        attributes_for(:balance_transaction,
          transactions_attributes: attributes_for(:transaction, amount: nil))
      end

      it 'does not create new transaction' do
        expect do
          post :create, params: {balance_transaction: attributes}
        end.not_to change(Transaction, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      let(:amount) { Faker::Number.decimal(3, 2).to_f }
      let(:transaction) { create(:transaction, :balance_transactions) }

      let(:params) do
        {
          id: transaction.transactinable.id,
          balance_transaction: attributes_for(
            :balance_transaction,
            transactions_attributes: attributes_for(
              :transaction,
              amount: amount,
              id: transaction.id
            )
          )
        }
      end

      before do
        put :update, params: params
        transaction.reload
      end

      it 'updates transaction amount' do
        expect(transaction.amount).to eq(amount)
      end

      it 'redirects after update' do
        put :update, params: params
        expect(response).to redirect_to transactions_path
      end
    end

    context 'when not valid' do
      let(:init_amount) { transaction.amount }
      let(:init_date) { transaction.date }

      let(:params) do
        {
          id: transaction.transactinable.id,
          balance_transaction: attributes_for(
            :balance_transaction,
            transactions_attributes: attributes_for(
              :transaction,
              amount: nil,
              id: transaction.id
            )
          )
        }
      end

      before do
        put :update, params: params
        transaction.reload
      end

      it 'transaction not updates when invalid amount' do
        expect(transaction.amount).to eq(init_amount)
      end
    end
  end
end
