class MakeTransactionsActAsPolymorphic < ActiveRecord::Migration[5.1]
  def up
    add_column :transactions, :transactinable_type, :string
    add_column :transactions, :transactinable_id, :integer

    migrate_comment_and_date_to_balance

    remove_column :transactions, :comment, :string
    remove_column :transactions, :date, :date
  end

  def down
    remove_column :transactions, :transactinable_type, :string
    remove_column :transactions, :transactinable_id, :integer
    add_column :transactions, :comment, :string
    add_column :transactions, :date, :date
  end

  private

  def migrate_comment_and_date_to_balance
    Transaction.find_each do |transaction|
      balance_transaction = BalanceTransaction.create(
        comment: transaction.comment,
        date: transaction.date
      )
      transaction.update(transactinable: balance_transaction)
    end
  end
end
