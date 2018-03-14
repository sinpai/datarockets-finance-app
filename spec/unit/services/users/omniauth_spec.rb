require 'rails_helper'

describe Users::Omniauth do
  let(:auth) { mock_github_provider }

  describe 'user creation' do
    it 'returns a user' do
      user = Users::Omniauth.new(auth).get
      expect(user).to be_a_kind_of(User)
    end
  end
end
