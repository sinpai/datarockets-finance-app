module TransactionsFeatureHelper
  def fill_transaction_form(rand_num, edit = false)
    page.should have_css('#modal-window', visible: true)
    rand_num += 23 if edit
    fill_data_in_fields(rand_num)
  end

  def fill_data_in_fields(rand_num)
    within '#modal-window .modal-body form' do
      fill_in 'transaction[amount]', with: rand_num
    end
    click_on 'Save'
  end
end
