class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_request, only: %i[show update destroy]

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Generate a token for the user, and include it in the response
      command = AuthenticateUser.call(user_params[:username], user_params[:password])

      if command.success?
        render json: { auth_token: command.result, user: @user }, status: :created
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :role,
    )
  end
end
