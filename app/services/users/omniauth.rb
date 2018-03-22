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
    @_user ||= User.find_by(email: email) || create_user
  end

  def create_user
    Users::Creator.new(email).call
  end

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info
end
