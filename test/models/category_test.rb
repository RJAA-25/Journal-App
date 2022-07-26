require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @valid_user = User.create(first_name: "Valid", last_name: "Example", username: "validExample", email: "valid_example@email.com", password: "password")
    @category = Category.new(name: "Some Name", description: "Some description", user_id: @valid_user.id)
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
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    assert_equal @valid_category.theme_color, "#540D6E"
  end

  test "should not save without a theme color" do
    @category.theme_color = nil
    assert_not @category.save
  end

  test "should not save a theme color not present in the given selection" do
    @category.theme_color = "#FFFFFF"
    assert_not @category.save

    @category.theme_color = "#540D6E"
    assert @category.save
  end


  # Model Association
  # Category - User
  test "should get details of parent user" do
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    assert_equal @valid_category.user.email, "valid_example@email.com"
    assert_equal @valid_category.user.username, "validExample"
  end

  # Category - Task
  test "should get task count under a category" do
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    assert_equal @valid_category.tasks.count, 0

    @valid_task= Task.create(name: "Valid Task", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @valid_category.id)
    assert_equal @valid_category.tasks.count, 1
  end
    
  test "should get task details under a category" do
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    @valid_task= Task.create(name: "Valid Task", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @valid_category.id)
    assert_equal @valid_category.tasks.last.name, "Valid Task"
  end

  test "should destory associated tasks when deleted" do
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    @valid_task= Task.create(name: "Valid Task", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @valid_category.id)
    assert_difference "Category.count", -1, "Task.count", -1 do
      @valid_category.destroy
    end
  end
end
