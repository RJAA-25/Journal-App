require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    @category = Category.create(name: "Some Name", description: "Some description", user_id: @user.id)
  end

  test "should reach show controller action" do
    get category_path(@user.username, @category)
    assert_response :success
  end

  test "should reach new controller action" do
    get new_category_path(@user.username)
    assert_response :success
  end

  test "should reach create controller action" do
    assert_difference "Category.count", 1 do
      post categories_path(@user.username), params: { category: { name: "Another Name", description: "Some description", theme_color: "#540D6E" } }
    end
    assert_redirected_to category_path(@user.username, Category.last)
  end

  test "should fail create controller action with invalid input" do
    assert_no_difference "Category.count" do
      post categories_path(@user.username), params: { category: { name: nil, description: "Some description", theme_color: "#540D6E" } }
    end
    assert_response :unprocessable_entity
  end

  test "should reach edit controller action" do
    get edit_category_path(@user.username, @category)
    assert_response :success
  end

  test "should reach update controller action" do
    assert_no_difference "Category.count" do
      patch category_path(@user.username, @category), params: { category: { name: "New Name", description: "Some description", theme_color: "#540D6E" } }
    end
    assert_redirected_to category_path(@user.username, @category)
  end

  test "should fail update controller action with invalid input" do
    assert_no_difference "Category.count" do
      patch category_path(@user.username, @category), params: { category: { name: nil, description: "Some description", theme_color: "#540D6E" } }
    end
    assert_response :unprocessable_entity
  end

  test "should reach destroy controller action" do
    assert_difference "Category.count", -1 do
      delete category_path(@user.username, @category)
    end
    assert_redirected_to dashboard_path(@user.username)
  end

  
  # Restrictions
  test "should not reach show, new, edit actions when not signed_in" do
    sign_out(@user)

    get category_path(@user.username, @category)
    assert_response :redirect 
    assert_redirected_to new_user_session_path

    get new_category_path(@user.username)
    assert_response :redirect 
    assert_redirected_to new_user_session_path

    get edit_category_path(@user.username, @category)
    assert_response :redirect 
    assert_redirected_to new_user_session_path
  end

  test "should not reach show, new, edit actions of other accounts" do
    get category_path("anotherAccount", @category)
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)

    get new_category_path("anotherAccount")
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)

    get edit_category_path("anotherAccount", @category)
    assert_response :redirect
    assert_redirected_to dashboard_path(@user.username)
  end
end
