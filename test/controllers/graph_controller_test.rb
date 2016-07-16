require 'test_helper'

class GraphControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get graph_url
    assert_response :success
  end

end
