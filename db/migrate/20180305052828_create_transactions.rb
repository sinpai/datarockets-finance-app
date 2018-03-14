class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :sum
      t.date :date
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
