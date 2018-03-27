namespace :user do
  desc 'Adding default categories to the old users'
  task add_default_categories: :environment do
    User.find_each do |user|
      Users::DefaultCategoriesCreator.new(user).call
    end
  end

  desc 'Convert old transactions to balance transactions'
  task convert_transactions: :environment do
    Transaction.find_each do |transaction|
      balance_transaction = BalanceTransaction.create(comment: nil)
      transaction.update(transactinable_type: BalanceTransaction,
                         transactinable_id: balance_transaction.id)
    end
  end
end
