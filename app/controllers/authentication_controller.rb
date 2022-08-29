class AuthenticationController < ApplicationController
  # Skip checking headers for user creation / login
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:username], params[:password])
    user = User.find_by(username: params[:username])

    if command.success?
      render json: { auth_token: command.result, user: user.as_json(only: [:id, :role, :username]) }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
