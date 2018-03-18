require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  before do
    FactoryBot.create_list(:transaction, 10, user: user, amount: 10)
  end

  context '.user_balance' do
    it 'returns correct total of balance' do
      expect(user.user_balance).to eq 100
    end
  end
end
