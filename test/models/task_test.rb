require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @valid_user = User.create(first_name: "Valid", last_name: "Example", username: "validExample", email: "valid_example@email.com", password: "password")
    @valid_category = Category.create(name: "Valid Category", description: "A description", user_id: @valid_user.id)
    @valid_task= Task.create(name: "Valid Task", details: "A detail", deadline: DateTime.current + 1.hour, category_id: @valid_category.id)
    @task = Task.new(name: "Task", details: "Some task details", deadline: DateTime.now + 1, category_id: @valid_category.id)
  end

  # :name attribute tests
  test "should not save without name" do
    @task.name = nil
    assert_not @task.save
  end

  test "should not save when name is less than 3 characters" do
    @task.name = "x" * 2
    assert_not @task.save
  end

  # :details attribute tests
  test "should not save without details" do
    @task.details = nil
    assert_not @task.save
  end

  test "should not save when details is less than 5 characters" do
    @task.details = "x" * 4
    assert_not @task.save
  end

  # :deadline attribute tests
  test "should not save without deadline" do
    @task.deadline = nil
    assert_not @task.save
  end

  test "should not save when deadline has passed" do
    @task.deadline = DateTime.now - 1
    assert_not @task.save

    @task.deadline = DateTime.now - 1.hour
    assert_not @task.save
  end

  # :completed attribute tests
  test "should not save when :completed is nil" do
    @task.completed = nil
    assert_not @task.save
  end

  # :overdue attribute tests
  test "should not save when :overdue is nil" do
    @task.overdue = nil
    assert_not @task.save
  end


  # Model Associations
  # Task - User
  test "should get details of user parent" do
    assert_equal @valid_task.category.user.username, "validExample"
    assert_equal @valid_task.category.user.email, "valid_example@email.com"
  end

  # Task - Category
  test "should get details of category parent" do
    assert_equal @valid_task.category.name, "Valid Category"
  end
end
