require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
    FactoryBot.create_list(:transaction, 10, user: @user, sum: 10)
  end

  context '.user_balance' do
    it 'returns correct total of balance' do
      expect(@user.user_balance).to eq 100
    end
  end
end
