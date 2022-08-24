require 'test_helper'

class DepositControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_buyer = create(:user, :buyer)
    @user_seller = create(:user, :seller)

    @buyer_token = JsonWebToken.encode(user_id: @user_buyer.id)
  end

  test 'should accept deposit from a buyer user' do
    deposit_amount = 5
    initial_deposit = @user_buyer.deposit

    post user_deposit_path(@user_buyer.id),
         params: {
           deposit: {
             amount: deposit_amount,
           },
         },
         as: :json,
         headers: { 'Authorization' => @buyer_token }

    assert @user_buyer.deposit, (initial_deposit + 5)
    assert_response 200
  end
end