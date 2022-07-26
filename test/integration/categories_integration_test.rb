require "test_helper"

class CategoriesIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    @category = Category.create(name: "Category 1", description: "This is a description", user_id: @user.id)
  end

  test "should create a new category" do
    get new_category_path(@user.username)
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path(@user.username), params: { category: { name: "Example", description: "This is a description", theme_color: "#540D6E" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Example", response.body
  end

  test "should fail creating a new category" do
    get new_category_path(@user.username)
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path(@user.username), params: { category: { name: "", description: "This is a description", theme_color: "#540D6E" } }
    end
    assert_response :unprocessable_entity
  end

  test "should show and update existing category" do
    get category_path(@user.username, @category)
    assert_response :success
    get edit_category_path(@user.username, @category)
    assert_response :success
    assert_no_difference "Category.count" do
      patch  category_path(@user.username, @category), params: { category: { name: "Example", description: "This is a description", theme_color: "#540D6E" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Example", response.body
  end

  test "should show and fail updating existing category" do
    get category_path(@user.username, @category)
    assert_response :success
    get edit_category_path(@user.username, @category)
    assert_response :success
    assert_no_difference "Category.count" do
      patch  category_path(@user.username, @category), params: { category: { name: "", description: "This is a description", theme_color: "#540D6E" } }
    end
  assert_response :unprocessable_entity
  end

  test "should delete an existing category" do
    get category_path(@user.username, @category)
    assert_response :success
    assert_difference "Category.count", -1 do
      delete category_path(@user.username, @category)
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_no_match "Category 1", response.body
  end
end 