class DepositController < ApplicationController
  before_action :set_user, only: %i[deposit reset]
  before_action :authenticate_request, only: %i[deposit reset]
  before_action :validate_user, only: %i[deposit reset]

  VALID_DEPOSIT_AMOUNTS = [5, 10, 20, 50, 100]

  def deposit
    amount = deposit_params[:amount]

    if valid_deposit?(amount)
      @user.with_lock do
        # This block is called within a transaction
        @user.deposit += amount
        @user.save
      end
      render json: @user, status: :ok
    else
      render json: { error: 'Invalid deposit' }, status: :bad_request
    end
  end

  def reset
    @user.with_lock do
      @user.deposit = 0
      @user.save
    end
    render json: @user, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def deposit_params
    params.require(:deposit).permit(:amount)
  end

  def validate_user
    unless @user.role == 'buyer'
      render json: { error: 'Invalid user' }, status: :bad_request and return true
    end
  end

  def valid_deposit?(amount)
    VALID_DEPOSIT_AMOUNTS.include?(amount)
  end
end
