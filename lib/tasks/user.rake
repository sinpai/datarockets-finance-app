namespace :user do
  desc 'Adding default categories to the old users'
  task add_default_categories: :environment do
    User.find_each do |user|
      Users::DefaultCategoriesCreator.new(user).call
    end
  end
end
