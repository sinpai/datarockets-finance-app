require 'rails_helper'

describe BalanceTransactions::Creator do
  context 'when valid' do
    let(:user) { create(:user) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Lorem.word }
    let(:amount) { Faker::Number.digit.to_i }
    let(:params) { {date: date, comment: comment, amount: amount, user_id: user.id} }

    it 'creates Balance Transaction' do
      expect do
        described_class.new(params).call
      end.to change(BalanceTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).call
      end.to change(Transaction, :count).by(1)
    end
  end

  context 'when not valid' do
    let(:user) { create(:user) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Lorem.word }
    let(:params) { {date: date, comment: comment, amount: nil, user_id: user.id} }

    it 'doesnt create Transaction' do
      expect do
        described_class.new(params).call
      end.to change(Transaction, :count).by(0)
    end
  end
end
