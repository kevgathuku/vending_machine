class DepositController < ApplicationController
  before_action :set_user, only: %i[deposit]
  before_action :authenticate_request, only: %i[deposit]

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

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def deposit_params
    params.require(:deposit).permit(:amount)
  end

  def valid_deposit?(amount)
    VALID_DEPOSIT_AMOUNTS.include?(amount)
  end
end
