require 'faker'

module TransactionsFeatureHelper
  def fill_transaction_form(rand_num, edit = false)
    page.should have_css('#modal-window', visible: true)
    rand_num = Faker::Number.decimal(3, 2) if edit
    fill_data_in_fields(rand_num)
  end

  def fill_data_in_fields(rand_num)
    within '#modal-window .modal-body form' do
      fill_in 'balance_transaction[transactions_attributes][amount]', with: rand_num
      fill_in 'balance_transaction[comment]', with: Faker::Lorem.word
    end
    click_on 'Save'
  end
end
