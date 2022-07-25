require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
  end

  test "should reach home controller action" do
    get root_path
    assert_response :success

    sign_in(@user)
    get root_path
    assert_response :success
  end

  test "should reach dashboard controller action" do
    sign_in(@user)
    get dashboard_path(@user.username)
    assert_response :success
  end

  test "should reach profile controller action" do
    sign_in(@user)
    get profile_path(@user.username)
    assert_response :success
  end

end
