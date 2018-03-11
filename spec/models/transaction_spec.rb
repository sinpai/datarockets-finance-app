require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:all) do
    FactoryBot.create_list(:transaction, 12)
  end

  describe 'named scope most_recent' do
    it 'should return only 10 records' do
      result = Transaction.most_recent
      result.length.should eq(10)
    end
  end
end
