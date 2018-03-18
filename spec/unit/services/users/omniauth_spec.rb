require 'rails_helper'

describe Users::Omniauth do
  context 'when signing with Github' do
    let(:auth) { mock_oauth_provider('github') }

    context 'when user created' do
      it 'returns a user' do
        user = Users::Omniauth.new(auth).get
        expect(user).to be_a_kind_of(User)
      end
    end
  end

  context 'when signing with Github' do
    let(:auth) { mock_oauth_provider('google_oauth2') }

    context 'when user created' do
      it 'returns a user' do
        user = Users::Omniauth.new(auth).get
        expect(user).to be_a_kind_of(User)
      end
    end
  end
end
