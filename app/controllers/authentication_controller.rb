require 'dry/matcher/result_matcher'

class AuthenticationController < ApplicationController
  # Skip checking headers for user creation / login
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUserCredentials.new
    user_token = command.call(username: params[:username], password: params[:password])

    Dry::Matcher::ResultMatcher.(user_token) do |m|
      m.success do |result|
        user = User.find_by(username: params[:username])
        render json: { auth_token: result, user: user.as_json(only: [:id, :role, :username]) }
      end

      m.failure do |err|
        render json: { error: err }, status: :unauthorized
      end
    end
  end
end
