require 'rails_helper'

RSpec.feature 'Transactions', type: :feature do
  context 'as logged in' do
    let(:rand_num) { Faker::Number.digit.to_i }
    let(:new_comment) { Faker::Lorem.sentence }
    let(:day_in_past) { Date.current.day - 3 }
    let(:user) { create :user }

    before(:each) do
      login_like_user(user)
      visit '/transactions'
    end

    it 'checks correct header' do
      expect(page).to have_content 'All transactions'
    end

    context 'adding new transaction' do
      it 'adds new transaction using modal window' do
        click_on 'New transaction'
        page.should have_css('#modal-window', visible: true)
        within '#modal-window .modal-body form' do
          fill_in 'transaction[sum]', with: rand_num
          select day_in_past, from: 'transaction[date(3i)]'
          fill_in 'transaction[comment]', with: new_comment
        end
        click_on 'Save'

        page.should have_content('Record has been successfully added')
      end
    end

    context 'editing transaction' do
      it 'edits existing transaction using modal window' do
        click_on 'Edit', match: :first
        page.should have_css('#modal-window', visible: true)
        within '#modal-window .modal-body form' do
          fill_in 'transaction[sum]', with: rand_num + 23
          fill_in 'transaction[comment]', with: new_comment + 'Updated'
        end
        click_on 'Save'

        page.should have_content('Record has been updated successfully')
      end
    end

    context 'deleting transaction' do
      it 'deletes transaction' do
        click_on 'Delete', match: :first

        page.should have_content('Record deleted successfully')
      end
    end
  end

  context 'as unlogged' do
    it 'checks correct redirect' do
      visit '/transactions'
      expect(page).to have_content 'Please sign in before accessing this section'
    end
  end
end
