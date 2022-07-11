require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = Task.create(name: "Task", details: "Some task details", deadline: DateTime.now + 1, completed: false)
  end

  test "should not save without name" do
    flunk
  end

  test "should not save when name is less than 4 characters" do
    flunk
  end

  test "should not save without details" do
    flunk
  end

  test "should not save when deadline has passed" do
    flunk
  end

  test ""
end
