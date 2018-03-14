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
end
