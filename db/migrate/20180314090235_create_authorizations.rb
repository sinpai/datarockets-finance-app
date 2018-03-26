class CreateAuthorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user
      t.timestamps
    end
  end
end
