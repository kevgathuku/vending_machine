require 'test_helper'

class DepositControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_buyer = create(:user, :buyer)
    @user_seller = create(:user, :seller)

    @buyer_token = JsonWebToken.encode(user_id: @user_buyer.id)
    @seller_token = JsonWebToken.encode(user_id: @user_seller.id)
  end

  test 'should accept deposit from a buyer' do
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

    assert_equal @user_buyer.reload.deposit, (initial_deposit + deposit_amount)
    assert_equal @response.parsed_body['deposit'], (initial_deposit + deposit_amount)
    assert_response 200
  end

  test 'should not accept any deposit from a seller' do
    deposit_amount = 5
    initial_deposit = @user_seller.deposit

    post user_deposit_path(@user_seller.id),
         params: {
           deposit: {
             amount: deposit_amount,
           },
         },
         as: :json,
         headers: { 'Authorization' => @seller_token }

    assert_equal @user_seller.deposit, initial_deposit
    assert_response 400
  end

  test 'should not accept invalid deposit amount from a buyer' do
    deposit_amount = 4
    initial_deposit = @user_buyer.deposit

    post user_deposit_path(@user_buyer.id),
         params: {
           deposit: {
             amount: deposit_amount,
           },
         },
         as: :json,
         headers: { 'Authorization' => @buyer_token }

    assert @user_buyer.deposit, initial_deposit
    assert_response 400
  end
end
