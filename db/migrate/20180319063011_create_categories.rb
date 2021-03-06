class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.float :amount, default: 0, null: false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
