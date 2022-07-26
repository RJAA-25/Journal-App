require "test_helper"

class PagesIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should reach dashboard page after successful login" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    get new_user_session_path
    assert_response :success
    post user_session_path, params: { user: { email: "username@email.com", password: "password" } }
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end

  test "should reach dashboard after successful sign up" do
    get new_user_registration_path
    assert_response :success
    post "/users", params: { user: { first_name: "New", last_name: "User", username: "newUser", email: "newUser@email.com ", password: "password", password_confirmation: "password" } }
    assert_response :redirect
    assert_redirected_to dashboard_path("newUser")
  end

  test "should reach profile page" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    get profile_path(@user.username)
    assert_response :success
  end

  test "should not reach dashboad of other accounts" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    get dashboard_path("anotherAccount")
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end

  test "should not reach profile of other accounts" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    get profile_path("anotherAccount")
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end
end