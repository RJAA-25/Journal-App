require "test_helper"

class CategoryFlowTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Category 1", description: "This is a description")
  end

  test "should create a new category" do
    get new_category_path
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Example", description: "This is a description", theme_color: "#540D6E" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Example", response.body
  end

  test "should show and update existing category" do
    get category_path(@category)
    assert_response :success
    get edit_category_path(@category)
    assert_response :success
    assert_no_difference "Category.count" do
      patch  category_path(@category), params: { category: { name: "Example", description: "This is a description", theme_color: "#540D6E" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Example", response.body
  end

  test "should delete an existing category" do
    get category_path(@category)
    assert_response :success
    assert_difference "Category.count", -1 do
      delete category_path(@category)
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_no_match "Category 1", response.body
  end

end 