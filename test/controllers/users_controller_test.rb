require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_url(id: 1)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(id: 1)
    assert_response :success
  end

end
