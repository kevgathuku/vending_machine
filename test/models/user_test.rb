require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without username' do
    user = User.new
    assert_not user.save
  end

  test 'should not save user without password' do
    user = User.create(username: 'abcdef')
    assert_not user.save
  end

  test 'should save user given username and password' do
    user = User.create(username: 'abcdef', password: '123456')
    assert user.save
  end

  test 'should not create users with duplicate usernames' do
    user = User.create(username: 'duplicate', password: '123456')
    user_dup = User.create(username: 'duplicate', password: '2345678')
    assert_not user_dup.save
  end

  test 'new user should have deposit set to zero' do
    user = User.create(username: 'new_user', password: '123456')
    assert_equal user.deposit, 0
  end
end
