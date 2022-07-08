require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # :name attribute tests
  test "should not save without name" do
    @category = Category.new(description: "Some description", theme_color: "#540D6E")
    assert_not @category.save
  end

  test "should not save when name is less than 5 characters" do
    @category = Category.new(name: "Some", description: "Some description", theme_color: "#540D6E")
    assert_not @category.save
  end

  test "should not save when name is not unique" do
    @category1 = Category.create(name: "Some Name", description: "Some description", theme_color: "#540D6E")
    @category2 = Category.new(name:"some name", description: "Some description", theme_color: "#540D6E")
    assert_not @category2.save
  end

  # :description attribute tests
  test "should not save without description" do
    @category = Category.new(name: "Some Name", theme_color: "#540D6E")
    assert_not @category.save
  end

  test "should not save when description is less than 10 characters" do
    @category = Category.new(name: "Some Name", description: "Some text", theme_color: "#540D6E")
    assert_not @category.save
  end

  # :theme_color attribute tests
  test "should not save without a theme color" do
    @category = Category.create(name: "Some Name", description: "Some description")
    assert @category.theme_color == "#540D6E"

    @category = Category.new(name: "Some Name", description: "Some description", theme_color: nil)
    assert_not @category.save
  end

end
