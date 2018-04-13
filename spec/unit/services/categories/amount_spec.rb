require 'rails_helper'

describe Categories::Amount do
  let(:user) { create(:user) }
  let(:balance) { Faker::Number.decimal(4, 2).to_f }
  let(:date) { Faker::Date.between(1.year.ago, Date.current) }
  let(:balance_params) { {date: date, amount: balance, user_id: user.id, comment: nil} }

  let(:amount) { Faker::Number.decimal(3, 2).to_f }
  let(:first_category) { create(:category, :top_category) }
  let(:second_category) { create(:category, :sub_category, categorizable: first_category) }
  let(:third_category) { create(:category, :sub_category, categorizable: second_category) }
  let(:params) { {amount: amount, user_id: user.id, category_id: third_category.id} }

  before do
    BalanceTransactions::Creator.new(balance_params).call
    CategoryTransactions::Creator.new(params).call
  end

  it 'shows correct amount' do
    expect(described_class.new(first_category).calculate).to eq(amount)
  end
end
