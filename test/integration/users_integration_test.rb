require "test_helper"

class UsersIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should reach login page" do
    get new_user_session_path
    assert_response :success
  end

  test "should reach dashboard page after successful login" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")

    get new_user_session_path
    assert_response :success
    post user_session_path, params: { user: { email: "username@email.com", password: "password" } }
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end

  test "should return to login page after unsuccessful login" do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")

    get new_user_session_path
    assert_response :success
    post user_session_path, params: { user: { email: "wrong@email.com", password: "wrong" } }
    assert_response :success
    assert_match "Log In", response.body
  end

  test "should reach register page" do
    get new_user_registration_path
    assert_response :success
  end

  test "should reach dashboard after successful sign up" do
    get new_user_registration_path
    assert_response :success
    post "/users", params: { user: { first_name: "New", last_name: "User", username: "newUser", email: "newUser@email.com ", password: "password", password_confirmation: "password" } }
    assert_response :redirect
    assert_redirected_to dashboard_path("newUser")
  end

  test "should return to register page after unsuccessful sign up" do
    get new_user_registration_path
    assert_response :success
    post "/users", params: { user: { first_name: "New", last_name: "User" } }
    assert_response :unprocessable_entity
    assert_match "Register", response.body
  end

  # test "should update profile" do
  #   user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
  #   sign_in(@user)
  #   get profile_edit_path(@user.username)
  #   assert_response :success
  #   patch user_registration_path, params: { user: { first_name: "First", last_name: "Last", username: "username", email: "username@email.com", password: "", password_confirmation: "", current_password: "password" } }
  #   assert_response :success
  # end
end