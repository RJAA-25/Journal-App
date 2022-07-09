require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new(name: "Some Name", description: "Some description")
  end

  # :name attribute tests
  test "should not save without name" do
    @category.name = nil
    assert_not @category.save
  end

  test "should not save when name is less than 5 characters" do
    @category.name = "x" * 4
    assert_not @category.save
  end

  test "should not save when name is more than 20 characters" do
    @category.name = "x" * 21
    assert_not @category.save
  end

  test "should not save when name is not unique" do
    assert @category.save
    @category_same = Category.new(name:"some name", description: "Some description", theme_color: "#540D6E")
    assert_not @category_same.save
  end

  # :description attribute tests
  test "should not save without description" do
    @category.description = nil
    assert_not @category.save
  end

  test "should not save when description is less than 10 characters" do
    @category.description = "x" * 9
    assert_not @category.save
  end

  # :theme_color attribute tests
  test "should save with a default theme color" do
    @category.save
    assert @category.theme_color == "#540D6E"
  end

  test "should not save without a theme color" do
    @category.theme_color = nil
    assert_not @category.save
  end


end
