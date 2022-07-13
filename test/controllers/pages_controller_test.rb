require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should reach home controller action" do
    get root_path
    assert_response :success
  end

  test "should reach dashboard controller action" do
    get dashboard_path
    assert_response :success
  end

end
