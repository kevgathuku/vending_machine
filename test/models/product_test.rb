require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @user_buyer = create(:user, :buyer)
    @user_seller = create(:user, :seller)
    @other_seller = create(:user, :seller)
  end

  test 'should allow sellers to create products' do
    product = build(:product, seller: @user_seller)
    assert product.save
  end

  test 'should not allow buyers to create products' do
    product = build(:product, seller: @user_buyer)
    assert_not product.save
  end

  test 'should not allow negative amounts' do
    product = build(:product, seller: @user_seller, amount_available: -1)
    assert_not product.save
  end
end
