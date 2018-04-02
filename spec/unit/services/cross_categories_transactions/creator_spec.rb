require 'rails_helper'

describe CrossCategoriesTransactions::Creator do
  context 'when valid' do
    let(:user) { create(:user) }

    let(:amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }
    let(:amount_from) { BigDecimal.new(1000) }
    let(:initial_amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }

    let(:category_from) { create(:category, :top_category, user: user, amount: amount_from) }
    let(:category_to) { create(:category, :top_category, user: user, amount: initial_amount) }

    let(:params) do
      {amount: amount, user_id: user.id, category_from_id: category_from.id,
       category_to_id: category_to.id}
    end

    it 'creates CrossCategoriesTransaction' do
      expect do
        described_class.new(params).call
      end.to change(CrossCategoriesTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).call
      end.to change(Transaction, :count).by(1)
    end

    context 'when transaction created update balance' do
      before do
        described_class.new(params).call
        category_from.reload
        category_to.reload
      end

      it 'Update category_from amount' do
        expect(category_from.amount).to eq(amount_from - amount)
      end

      it 'Update category_to amount' do
        expect(category_to.amount).to eq(initial_amount + amount)
      end
    end
  end

  context 'when not valid' do
    let(:user) { create(:user) }

    let(:amount) { BigDecimal.new(Faker::Number.decimal(4, 2)) }
    let(:category_amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }

    let(:category_from) { create(:category, :top_category, user: user, amount: category_amount) }
    let(:category_to) { create(:category, :top_category, user: user, amount: category_amount) }

    let(:initial_category_from_amount) { category_from.amount }
    let(:initial_category_to_amount) { category_to.amount }

    let(:params) do
      {amount: amount, user_id: user.id, category_from_id: category_from.id,
       category_to_id: category_to.id}
    end

    before do
      described_class.new(params).call
      category_from.reload
      category_to.reload
    end

    it 'creates CrossCategoriesTransaction' do
      expect { }.to change(CrossCategoriesTransaction, :count).by(0)
    end

    it 'creates Transaction' do
      expect { }.to change(Transaction, :count).by(0)
    end

    it 'Update category_from amount' do
      expect(category_from.amount).to eq(initial_category_from_amount)
    end

    it 'Update category_to amount' do
      expect(category_to.amount).to eq(initial_category_to_amount.to_f)
    end
  end
end
