require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @new_category = Category.create(name: "Example", description: "A description")
    @new_task = Task.create(name:"Task #1", details: "A task detail", deadline: DateTime.now + 2 , category_id: Category.last.id)
    @category = Category.new(name: "Some Name", description: "Some description")
  end

  # :name attribute tests
  test "should not save without name" do
    @category.name = nil
    assert_not @category.save
  end

  test "should not save when name is less than 3 characters" do
    @category.name = "x" * 2
    assert_not @category.save
  end

  test "should not save when name is more than 15 characters" do
    @category.name = "x" * 16
    assert_not @category.save
  end

  # :description attribute tests
  test "should not save without description" do
    @category.description = nil
    assert_not @category.save
  end

  test "should not save when description is less than 5 characters" do
    @category.description = "x" * 4
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

  test "should not save a theme color not present in the given selection" do
    @category.theme_color = "#FFFFFF"
    assert_not @category.save

    @category.theme_color = "#3A5A40"
    assert @category.save
  end

  # Model Associations

  # Category - Task
  test "should get task count under a category" do
    @category.save
    assert_equal @category.tasks.count, 0
  end
    
  test "should get task details under a category" do
    @task = Category.last.tasks.last
    assert_equal @task.name, "Task #1"
  end
end
