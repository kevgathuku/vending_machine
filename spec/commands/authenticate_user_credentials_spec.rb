require 'rails_helper'

RSpec.describe AuthenticateUserCredentials do
  subject(:result) { described_class.new.call(user_params) }

  context 'with valid user credentials' do
    let(:user_params) { { username: 'qwerty', password: 'poiuytr' } }
    let!(:user) { User.create(user_params) }

    it 'returns a token' do
      expect(result).to be_success
    end
  end
end
