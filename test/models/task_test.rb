require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @category = Category.create(name: "Some Name", description: "Some description")
    @task = Task.new(name: "Task", details: "Some task details", deadline: DateTime.now + 1, category_id: @category.id)
  end

  # :name attribute tests
  test "should not save without name" do
    @task.name = nil
    assert_not @task.save
  end

  test "should not save when name is less than 4 characters" do
    @task.name = "x" * 3
    assert_not @task.save
  end

  # :details attribute tests
  test "should not save without details" do
    @task.details = nil
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

end
