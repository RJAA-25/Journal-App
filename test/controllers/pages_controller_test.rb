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


  # Restrictions
  test "should not reach dashboard, profile when not signed in" do
    get dashboard_path(@user.username)
    assert_response :redirect 
    assert_redirected_to new_user_session_path

    get profile_path(@user.username)
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should not reach dashboard of other accounts" do
    sign_in(@user)
    get dashboard_path("anotherAccount")
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end  

  test "should not reach profile of other accountes" do
    sign_in(@user)
    get profile_path("anotherAccount")
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end
end
