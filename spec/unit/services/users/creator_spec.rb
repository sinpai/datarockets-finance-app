require 'rails_helper'

describe Users::Creator do
  describe '.call' do
    let(:user_email) { Faker::Internet.email }

    context 'when email is provided' do
      let(:user) { described_class.new(user_email).call }

      it 'have user created' do
        expect(user).to be_kind_of(User)
      end

      it 'have default categories' do
        expect(user.categories.first.name).to eq('Transportation')
      end
    end
  end
end
