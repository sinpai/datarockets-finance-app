require 'rails_helper'

describe BalanceTransactions::Updater do
  context 'when valid' do
    let(:amount) { Faker::Number.decimal(3, 2) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Lorem.word }
    let(:transaction) { create(:transaction, :balance_transactions) }
    let(:params) { {date: date, comment: comment, amount: amount, transaction_id: transaction.id} }

    before do
      described_class.new(params).call
      transaction.reload
    end

    it 'updates transaction amount' do
      expect(transaction.amount).to eq(amount)
    end

    it 'updates transaction date' do
      expect(transaction.transactinable.date).to eq(date)
    end

    it 'updates transaction comment' do
      expect(transaction.transactinable.comment).to eq(comment)
    end
  end

  context 'when not valid' do
    let!(:transaction) { create(:transaction, :balance_transactions) }
    let(:init_amount) { transaction.amount }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Lorem.word }

    let(:params) { {date: date, comment: comment, amount: nil, transaction_id: transaction.id} }

    before do
      described_class.new(params).call
      transaction.reload
    end

    it 'not updates transaction amount' do
      expect(transaction.amount).to eq(init_amount)
    end
  end
end
