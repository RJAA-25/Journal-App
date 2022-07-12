require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Some Name", description: "Some description")
    @task = Task.create(name: "Some Task", details: "Some details", deadline: DateTime.now + 1, category_id: @category.id)
  end

  test "should reach index controller action" do
    get category_tasks_path(@category.id)
    assert_response :success
  end

  test "should reach show controller action" do
    get category_task_path(@category.id, @task)
    assert_response :success
  end

  test "should reach new controller action" do
    get new_category_task_path(@category.id)
    assert_response :success
  end

  test "should reach create controller action" do
    assert_difference "Task.count", 1 do
      post category_tasks_path(@category.id), params: { task: { name: "Some Task", details: "Some details", deadline: DateTime.now + 1 } }
    end
    assert_redirected_to category_task_path(@category.id, Task.last)
  end

  test "should reach edit controller action" do
    get edit_category_task_path(@category.id, @task)
    assert_response :success
  end

  test "should reach update controller action" do
    assert_no_difference "Task.count" do
      patch category_task_path(@category.id, @task), params: { task: { name: "New Name", description: "Some Description", deadline: DateTime.now + 2 } }
    end
    assert_redirected_to category_task_path(@category.id, @task)
  end

  test "should reach destroy controller action" do
    assert_difference "Task.count", -1 do
      delete category_task_path(@category.id, @task.id)
    end
    assert_redirected_to category_tasks_path(@category.id)
  end
end
