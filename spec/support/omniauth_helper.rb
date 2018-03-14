module OmniauthHelper
  def self.included(_)
    OmniAuth.config.test_mode = true
  end

  def mock_github_provider
    OmniAuth.config.add_mock(:github, omniauth_hash)
  end

  private

  def omniauth_hash
    {
      'provider' => 'github',
      'uid' => '12345',
      'info' => {
        'name' => 'test',
        'email' => 'test@github.com',
        'nickname' => 'test'
      },
      'extra' => {
        'raw_info' => {
          'location' => 'San Francisco',
          'gravatar_id' => '123456789'
        }
      }
    }
  end
end
