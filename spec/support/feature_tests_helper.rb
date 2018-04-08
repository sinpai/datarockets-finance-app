module FeatureTestsHelper
  def login_like_user(user)
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Sign in'
    expect(page).to have_content 'Signed in successfully'

    create_list(:transaction, 5, :balance_transactions, user: user)
  end
end
