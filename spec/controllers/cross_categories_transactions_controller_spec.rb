require 'rails_helper'

RSpec.describe CrossCategoriesTransactionsController, type: :controller do
  let(:user) { create(:user) }

  login_user

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:amount) { Faker::Number.decimal(3, 2).to_f }
      let(:amount_from) { amount + Faker::Number.digit.to_f }
      let(:category_from) do
        create(:category, :top_category, user: subject.current_user, amount: amount_from)
      end
      let(:category_to) { create(:category, :top_category, user: subject.current_user) }

      let(:params) do
        {
          amount: amount,
          cross_categories_transactions_attributes: {
            category_from_id: category_from.id,
            category_to_id: category_to.id
          }
        }
      end

      it 'creates transaction' do
        expect do
          post :create, params: {transaction: params}
        end.to change(CrossCategoriesTransaction, :count).by(1)
      end

      it 'redirects after create' do
        post :create, params: {transaction: params}
        expect(response).to redirect_to categories_path
      end
    end

    context 'when not valid' do
      let(:amount_from) { Faker::Number.decimal(3, 2).to_f }
      let(:amount) { amount_from + Faker::Number.digit.to_f }
      let(:category_from) do
        create(:category, :top_category, user: subject.current_user, amount: amount_from)
      end
      let(:category_to) { create(:category, :top_category, user: subject.current_user) }

      let(:params) do
        {
          amount: amount,
          cross_categories_transactions_attributes: {
            category_from_id: category_from.id,
            category_to_id: category_to.id
          }
        }
      end

      it 'not creates new transaction' do
        expect do
          post :create, params: {transaction: params}
        end.not_to change(Transaction, :count)
      end
    end
  end
end
