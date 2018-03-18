class Users::Omniauth < Struct.new(:auth)
  def get
    find_or_create_authorization
    user
  end

  private

  def find_or_create_authorization
    user.authorizations
        .create_with(uid: uid)
        .find_or_create_by(provider: provider)
  end

  def user
    @_user ||= User.find_or_create_by(email: email) do |user|
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Date.current
    end
  end

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info
end
