require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @category = Category.create(name: "Example", description: "A description")
    @task = Task.new(name: "Task", details: "Some task details", deadline: DateTime.now + 1, category_id: @category.id)
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

  # Category - Task
  test "should get details of category parent" do
    @task.save
    assert_equal @task.category.name, "Example"
  end
end
