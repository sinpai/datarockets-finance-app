require 'spec_helper'

describe Users::Omniauth do
  before do
    @auth = OmniAuth.config.mock_auth[:github]
  end

  describe 'user creation' do
    it 'should successfully return a user' do
      user = Users::Omniauth.new(@auth).get
      expect(user).to be_a_kind_of(User)
    end
  end
end
