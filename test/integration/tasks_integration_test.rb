require "test_helper"

class TaskFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
    sign_in(@user)
    @category = Category.create(name: "Category 1", description: "This is a description", user_id: @user.id)
    @task = @category.tasks.create(name: "Some Name", details: "Some details", deadline: DateTime.now + 1)
  end

  test "should create a new task" do
    get category_path(@user.username, @category)
    assert_response :success
    get new_category_path(@user.username, @category)
    assert_response :success
    assert_difference "Task.count", 1 do
      post category_tasks_path(@user.username, @category), params: { task: { name: "Example", details: "Some details", deadline: DateTime.now + 1} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Example", response.body
  end

  test "should show and update existing task" do
    get category_path(@user.username, @category)
    assert_response :success
    get category_task_path(@user.username, @category, @task)
    assert_response :success
    get edit_category_task_path(@user.username, @category, @task)
    assert_response :success
    assert_no_difference "Task.count" do
      patch category_task_path(@user.username, @category, @task), params: { task: { name: "New Name" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "New Name", response.body
  end

  test "should delete an existing task" do
    get category_path(@user.username, @category)
    assert_response :success
    get category_task_path(@user.username, @category, @task)
    assert_response :success
    assert_difference "Task.count", -1 do
      delete category_task_path(@user.username, @category, @task)
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_no_match "Some Name", response.body
  end
end 