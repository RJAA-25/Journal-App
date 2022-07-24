require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
  end

  # :first_name attribute tests
  test "should not save without first name" do
    @user.first_name = nil
    assert_not @user.save
  end

  # :last_name attribute tests
  test "should not save without last_name" do
    @user.last_name = nil
    assert_not @user.save
  end

  # :username attribute tests
  test "should not save without username" do
    @user.username = nil
    assert_not @user.save
  end

  test "should not save when username is less than 4 characters" do
    @user.username = "x" * 3
    assert_not @user.save
  end

  test "should not save when username is more than 15 characters" do
    @user.username = "x" * 16
    assert_not @user.save
  end

  # :email attribute tests
  test "should not save without email" do
    @user.email = nil
    assert_not @user.save
  end

  test "should not save when email is not unique" do
    @valid_user = User.create(first_name: "Valid", last_name: "Example", username: "validExample", email: "validExample@email.com", password: "password")
    @user.email = "validExample@email.com"
    assert_not @user.save
  end

  # :password attribute tests
  test "should not save without password" do
    @user.password = nil
    assert_not @user.save
  end

  test "should not save when password is less than 6 characters" do
    @user.password = "x" * 5
    assert_not @user.save
  end

  test "should not save when password is more than 128 characters" do
    @user.password = "x" * 129
    assert_not @user.save
  end

  
  # Model Associations
  # User - Category
  test "should get category count under a user" do
    @user.save
    assert_equal @user.categories.count, 0

    @category = Category.create(name: "Category", description: "A description", user_id: @user.id)
    assert_equal @user.categories.count, 1
  end

  test "should get category details under a user" do
    @user.save
    @category = Category.create(name: "Category", description: "A description", user_id: @user.id)
    assert_equal @user.categories.last.name, "Category"
  end

  # User - Task
  test "should get task count under a user" do
    @user.save
    @category = Category.create(name: "Category", description: "A description", user_id: @user.id)
    assert_equal @user.tasks.count, 0
    
    @task= Task.create(name: "Task#1", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @category.id)
    assert_equal @user.tasks.count, 1
  end

  # Dependent Destroy
  test "should destroy associated categories and tasks when deleted" do
    @user.save
    @category = Category.create(name: "Category", description: "A description", user_id: @user.id)
    @task = Task.create(name: "Task#1", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @category.id)
    assert_difference "User.count", -1, "Category.count", -1, "Task.count", -1  do
      @user.destroy
    end
  end
end
