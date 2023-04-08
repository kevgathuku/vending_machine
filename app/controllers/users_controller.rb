require 'dry/matcher/result_matcher'

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
      command = AuthenticateUserCredentials.new
      maybe_user_token = command.call(username: user_params[:username], password: user_params[:password])

      Dry::Matcher::ResultMatcher.(maybe_user_token) do |m|
        m.success do |token|
          render json: { auth_token: token, user: @user.as_json(:except => [:password_digest]) }, status: :created
        end

        m.failure do |err|
          render json: { error: err }, status: :unauthorized
        end
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
      :role
    )
  end
end
