module TransactionsFeatureHelper
  def fill_transaction_form(rand_num, new_comment, edit = false)
    page.should have_css('#modal-window', visible: true)
    if edit
      rand_num += 23
      new_comment += 'Updated'
    end
    fill_data_in_fields(rand_num, new_comment)
  end

  def fill_data_in_fields(rand_num, new_comment)
    within '#modal-window .modal-body form' do
      fill_in 'transaction[amount]', with: rand_num
      select day_in_past, from: 'transaction[date(3i)]'
      fill_in 'transaction[comment]', with: new_comment
    end
    click_on 'Save'
  end
end
