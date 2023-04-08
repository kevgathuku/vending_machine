require 'rails_helper'

RSpec.describe AuthenticateUserCredentials do
  context 'with valid user credentials' do
    let(:username) { 'qwerty' }
    let(:password) { 'poiuytr' }
    let(:user_params) { { username: username, password: password } }
    let!(:user) { User.create(user_params) }
    let(:result) { described_class.new.call(user_params) }

    it 'returns a token' do
      expect(result).to be_success
    end
  end
end
