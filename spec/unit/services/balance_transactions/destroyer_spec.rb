require 'rails_helper'

describe BalanceTransactions::Destroyer do
  context 'when valid' do
    let!(:transaction) { create(:transaction) }

    it 'deletes the balance transaction' do
      expect do
        described_class.new(transaction.id).call
      end.to change(BalanceTransaction, :count).by(-1)
    end

    it 'deletes the transaction' do
      expect do
        described_class.new(transaction.id).call
      end.to change(Transaction, :count).by(-1)
    end
  end
end
