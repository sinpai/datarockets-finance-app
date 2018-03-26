module OmniauthHelper
  def self.included(_)
    OmniAuth.config.test_mode = true
  end

  def mock_oauth_provider(provider)
    OmniAuth.config.add_mock(provider.to_sym, omniauth_hash(provider))
  end

  def stub_omniauth_provider(provider)
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(omniauth_hash(provider))
  end

  private

  def omniauth_hash(provider)
    {
      provider: provider,
      uid: Faker::Number.number(10),
      info: {
        email: Faker::Internet.email
      }
    }
  end
end
