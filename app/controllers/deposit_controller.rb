class DepositController < ApplicationController
  before_action :set_user, only: %i[deposit]
  before_action :authenticate_request, only: %i[deposit]

  def deposit
    deposit_amount = deposit_params[:amount]
    @user.with_lock do
      # This block is called within a transaction
      @user.deposit += deposit_amount
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
end
