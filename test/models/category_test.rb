require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    @category = Category.new(name: "Some Name", description: "Some description", user_id: @user.id)
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


  # Model Association
  # Category - User
  test "should get details of parent user" do
    @category.save
    assert_equal @category.user.email, "username@email.com"
    assert_equal @category.user.username, "username"
  end

  # Category - Task
  test "should get task count under a category" do
    @category.save
    @task = Task.create(name:"Task #1", details: "A detail", deadline: DateTime.now + 1.hour , category_id: @category.id)
    assert_equal @category.tasks.count, 1
  end
    
  test "should get task details under a category" do
    @category.save
    @task = Task.create(name:"Task #1", details: "A detail", deadline: DateTime.now + 1.hour , category_id: @category.id)
    assert_equal @category.tasks.last.name, "Task #1"
  end

  test "should destory associated tasks when deleted" do
    @category.save
    @task = Task.create(name:"Task #1", details: "A detail", deadline: DateTime.now + 1.hour , category_id: @category.id)
    assert_difference "Task.count", -1 do
      @category.destroy
    end
  end
end
