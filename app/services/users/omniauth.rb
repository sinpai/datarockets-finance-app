class Users::Omniauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def get
    check_auth
    @user
  end

  private

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info

  def find_authorization(user)
    user.authorizations.where(provider: provider, uid: uid).first
  end

  def create_authorization(user)
    user.authorizations.create(provider: provider, uid: uid)
  end

  def get_user
    @user = User.where(email: email).first || create_user
  end

  def check_auth
    get_user
    create_authorization(@user) if find_authorization(@user).blank?
  end

  def create_user
    user = User.new(
      email: email,
      password: Devise.friendly_token[0, 20]
    )
    user.skip_confirmation!
    user.save
    user
  end
end
