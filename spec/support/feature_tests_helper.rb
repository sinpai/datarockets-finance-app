module FeatureTestsHelper
  def login_like_user(user)
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Sign in'
    expect(page).to have_content 'Signed in successfully'

    create_transactions(5, user)
  end

  def create_transactions(num, user)
    FactoryBot.create_list(:transaction, num, user: user)
  end

  def fill_transaction_form(rand_num, new_comment, edit = false)
    page.should have_css('#modal-window', visible: true)
    if edit
      rand_num += 23
      new_comment += 'Updated'
    end
    within '#modal-window .modal-body form' do
      fill_in 'transaction[amount]', with: rand_num
      select day_in_past, from: 'transaction[date(3i)]'
      fill_in 'transaction[comment]', with: new_comment
    end
    click_on 'Save'
  end
end
