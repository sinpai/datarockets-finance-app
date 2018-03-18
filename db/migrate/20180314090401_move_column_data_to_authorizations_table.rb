class MoveColumnDataToAuthorizationsTable < ActiveRecord::Migration[5.1]
  def change
    User.where.not(category: [nil, '']) do |user|
      user.authorizations.create(
        provider: user.provider,
        uid: user.uid
      )
    end
  end
end
