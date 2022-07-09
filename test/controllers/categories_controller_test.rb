require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Some Name", description: "Some description")
  end

  test "should reach index controller action" do
    get categories_path
    assert_response :success
  end

  test "should reach show controller action" do
    get categories_path(@category)
    assert_response :success
  end

  test "should reach new controller action" do
    get new_category_path
    assert_response :success
  end

  test "should reach create controller action" do
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Another Name", description: "Some description", theme_color: "#540D6E" } }
    end
    assert_redirected_to categories_path(Category.last)
  end

  test "should reach edit controller action" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "should reach update controller action" do
    assert_no_difference "Category.count" do
      patch category_path(@category), params: { category: { name: "New Name", description: "Some description", theme_color: "#540D6E" } }
    end
    assert_redirected_to categories_path(@category)
  end

  test "should reach destroy controller action" do
    assert_difference "Category.count", -1 do
      delete category_path(@category)
    end
    assert_redirected_to categories_path
  end
end
