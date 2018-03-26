require 'rails_helper'

describe Users::DefaultCategoriesCreator do
  describe '.call' do
    let(:user) { create(:user) }

    context 'when user is provided' do
      before { described_class.new(user).call }

      it 'have default categories' do
        expect(user.categories.first.name).to eq('Transportation')
      end
    end
  end
end
