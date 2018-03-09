require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'POST create new transaction' do
    login_user
    let(:transaction_params) { FactoryBot.attributes_for :transaction }

    it 'has a 200 status code after create' do
      post :create, params: {transaction: transaction_params}
      assert_redirected_to root_path
    end
  end
end
