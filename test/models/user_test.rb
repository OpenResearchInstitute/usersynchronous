require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:normal)

    @valid_params = {
      email: 'test@user.com',
      password: 'testthis'
    }
  end
  
  test 'email address is uniq' do
    user1 = User.create(@valid_params)

    assert user1.valid?, 'WTF? our @valid_params are not valid!'

    assert user1.save

    user2 = User.create(@valid_params)

    refute user2.valid?,
           'User with duplicate email address was valid'

    assert_includes user2.errors.full_messages, "Email has already been taken",
                    'did not include an error message about Email already taken.'
  end

  test 'email address is required' do
    user = User.new

    refute user.valid?

  end
end
