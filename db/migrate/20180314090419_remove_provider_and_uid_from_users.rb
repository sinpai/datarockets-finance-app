class RemoveProviderAndUidFromUsers < ActiveRecord::Migration[5.1]
  class User < ApplicationRecord
    has_many :authorizations
  end

  class Authorization < ApplicationRecord
    belongs_to :user
  end

  def up
    migrate_auth_data_to_authorizations

    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end

  private

  def migrate_auth_data_to_authorizations
    User.where.not(provider: nil).find_each do |user|
      user.authorizations.create(
        provider: user.provider,
        uid: user.uid
      )
    end
  end
end
