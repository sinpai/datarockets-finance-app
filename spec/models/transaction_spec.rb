require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    FactoryBot.create_list(:transaction, 12)
  end

  describe '.most_recent' do
    it 'returns only 10 records' do
      expect(Transaction.most_recent.length).to eq 10
    end
  end
end
