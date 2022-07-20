require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Some Name", description: "Some description")
    @task = Task.create(name: "Some Task", details: "Some details", deadline: DateTime.now + 1, category_id: @category.id)
  end

  test "should reach show controller action" do
    get category_task_path(@category, @task)
    assert_response :success
  end

  test "should reach new controller action" do
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should reach create controller action" do
    assert_difference "Task.count", 1 do
      post category_tasks_path(@category), params: { task: { name: "Some Task", details: "Some details", deadline: DateTime.now + 1 } }
    end
    assert_redirected_to category_task_path(@category, Task.last)
  end

  test "should fail create controller action with invalid input" do
    assert_no_difference "Task.count" do
      post category_tasks_path(@category), params: { task: { name: nil, details: "Some details", deadline: DateTime.now + 1 } }
    end
    assert_response :unprocessable_entity
  end

  test "should reach edit controller action" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should reach update controller action" do
    assert_no_difference "Task.count" do
      patch category_task_path(@category, @task), params: { task: { name: "New Name", details: "Some details", deadline: DateTime.now + 2 } }
    end
    assert_redirected_to category_task_path(@category, @task)
  end

  test "should fail update controller action with invalid input" do
    assert_no_difference "Task.count" do
      patch category_task_path(@category, @task), params: { task: { name: nil, details: "Some details", deadline: DateTime.now + 1 } }
    end
    assert_response :unprocessable_entity
  end

  test "should reach destroy controller action" do
    assert_difference "Task.count", -1 do
      delete category_task_path(@category, @task)
    end
    assert_redirected_to category_path(@category)
  end

  test "should reach toggle_complete controller action" do
    assert_no_difference "Task.count" do
      patch category_task_toggle_path(@category, @task)
    end
    @same_task = Task.last
    assert_not_equal @task.completed, @same_task.completed
    assert_redirected_to category_task_path(@category, @task)
  end
end
