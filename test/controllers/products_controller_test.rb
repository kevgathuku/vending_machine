require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_buyer = create(:user, :buyer)
    @user_seller = create(:user, :seller)
    @other_seller = create(:user, :seller)

    @seller_token = JsonWebToken.encode(user_id: @user_seller.id)
    @other_seller_token = JsonWebToken.encode(user_id: @other_seller.id)
    @buyer_token = JsonWebToken.encode(user_id: @user_buyer.id)

    @product = create(:product, seller: @user_seller)
  end

  test 'should get index' do
    get products_url, as: :json
    assert_response :success
  end

  test 'should create product as a seller' do
    assert_difference('Product.count') do
      post products_url,
           params: {
             product: {
               amount_available: @product.amount_available,
               name: @product.name,
               price: @product.price,
               seller_id: @user_seller.id,
             },
           },
           as: :json,
           headers: { 'Authorization' => @seller_token }
    end

    assert_response 201
  end

  test 'should not create product if the user is a buyer' do
    assert_no_difference('Product.count') do
      post products_url,
           params: {
             product: {
               amount_available: @product.amount_available,
               name: @product.name,
               price: @product.price,
               seller_id: @user_buyer.id,
             },
           },
           as: :json,
           headers: { 'Authorization' => @buyer_token }
    end

    assert_response 422
  end

  test 'should show product' do
    get product_url(@product), as: :json
    assert_response :success
  end

  test 'the original seller should update product' do
    patch product_url(@product),
          params: {
            product: { amount_available: @product.amount_available,
                       name: @product.name,
                       price: @product.price },
          },
          as: :json,
          headers: { 'Authorization' => @seller_token }
    assert_response 200
  end

  test 'should not allow the other sellers to update the product' do
    patch product_url(@product),
          params: {
            product: { amount_available: @product.amount_available,
                       name: @product.name,
                       price: @product.price },
          },
          as: :json,
          headers: { 'Authorization' => @other_seller_token }
    assert_response 401
  end

  test 'should allow the owner to destroy a product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product), as: :json, headers: { 'Authorization' => @seller_token }
    end

    assert_response 204
  end

  test 'should not allow other sellers to destroy a product' do
    assert_no_difference('Product.count', -1) do
      delete product_url(@product), as: :json, headers: { 'Authorization' => @other_seller_token }
    end

    assert_response 401
  end
end
