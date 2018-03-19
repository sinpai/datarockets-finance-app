require 'rails_helper'

RSpec.describe 'Transactions', type: :feature do
  context 'when logged in' do
    let(:rand_num) { Faker::Number.digit.to_i }
    let(:new_comment) { Faker::Lorem.sentence }
    let(:day_in_past) { Date.current.day - 3 }
    let(:user) { create :user }

    before do
      login_like_user(user)
      visit '/transactions'
    end

    it 'checks correct header' do
      expect(page).to have_content 'All transactions'
    end

    context 'when adding new transaction' do
      it 'adds new transaction using modal window' do
        click_on 'Add new transaction'
        fill_transaction_form(rand_num, new_comment)
        page.should have_content('Record has been successfully added')
      end
    end

    context 'when editing transaction' do
      it 'edits existing transaction using modal window' do
        click_on 'Edit', match: :first
        fill_transaction_form(rand_num, new_comment, true)
        page.should have_content('Record has been updated successfully')
      end
    end

    context 'when deleting transaction' do
      it 'deletes transaction' do
        click_on 'Delete', match: :first

        page.should have_content('Record deleted successfully')
      end
    end
  end

  context 'when unlogged' do
    it 'checks correct redirect' do
      visit '/transactions'
      expect(page).to have_content 'Please sign in before accessing this section'
    end
  end
end
