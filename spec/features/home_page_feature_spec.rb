RSpec.feature "Home page content", :type => :feature do
  scenario "Check content on a home page" do
    visit '/'
    expect(page).to have_content 'First page of the app'
  end
end
