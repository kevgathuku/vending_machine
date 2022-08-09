require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_buyer = users(:buyer)
    @user_seller = users(:seller)
    @buyer_token = JsonWebToken.encode(user_id: @user_buyer.id)
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { username: 'buyer', password: 'random', role: @user_buyer.role } }, as: :json
    end

    assert_response 201

    json_response = JSON.parse(response.body).with_indifferent_access
    # Does not return the hashed password in the response
    assert_not json_response[:user][:password_digest]
    # Returns auth token in the response
    assert json_response[:auth_token]
  end

  test 'should show user' do
    get user_url(@user_buyer), as: :json, headers: { 'Authorization' => @buyer_token }
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user_buyer), params: { user: { username: 'buyer12', password: 'randompass' } }, as: :json, headers: { 'Authorization' => @buyer_token }
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user_buyer), as: :json, headers: { 'Authorization' => @buyer_token }
    end

    assert_response 204
  end
end
