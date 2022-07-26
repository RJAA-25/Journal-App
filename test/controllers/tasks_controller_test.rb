# require "test_helper"

# class TasksControllerTest < ActionDispatch::IntegrationTest
#   include Devise::Test::IntegrationHelpers

#   setup do
#     @user = User.create(first_name: "First", last_name: "Last", username: "username", email: "username@email.com ", password: "password")
#     sign_in(@user)
#     @category = Category.create(name: "Some Name", description: "Some description", user_id: @user.id)

#     @task = Task.create(name: "Some Task", details: "Some details", deadline: DateTime.now + 1, category_id: @category.id)
#   end

#   test "should reach show controller action" do
#     get category_task_path(@user.username, @category, @task)
#     assert_response :success
#   end

#   test "should reach new controller action" do
#     get new_category_task_path(@user.username, @category)
#     assert_response :success
#   end

#   test "should reach create controller action" do
#     assert_difference "Task.count", 1 do
#       post category_tasks_path(@user.username, @category), params: { task: { name: "Some Task", details: "Some details", deadline: DateTime.now + 1 } }
#     end
#     assert_redirected_to category_task_path(@user.username, @category, Task.last)
#   end

#   test "should fail create controller action with invalid input" do
#     assert_no_difference "Task.count" do
#       post category_tasks_path(@user.username, @category), params: { task: { name: nil, details: "Some details", deadline: DateTime.now + 1 } }
#     end
#     assert_response :unprocessable_entity
#   end

#   test "should reach edit controller action" do
#     get edit_category_task_path(@user.username, @category, @task)
#     assert_response :success
#   end

#   test "should reach update controller action" do
#     assert_no_difference "Task.count" do
#       patch category_task_path(@user.username, @category, @task), params: { task: { name: "New Name", details: "Some details", deadline: DateTime.now + 2 } }
#     end
#     assert_redirected_to category_task_path(@user.username, @category, @task)
#   end

#   test "should fail update controller action with invalid input" do
#     assert_no_difference "Task.count" do
#       patch category_task_path(@user.username, @category, @task), params: { task: { name: nil, details: "Some details", deadline: DateTime.now + 1 } }
#     end
#     assert_response :unprocessable_entity
#   end

#   test "should reach destroy controller action" do
#     assert_difference "Task.count", -1 do
#       delete category_task_path(@user.username, @category, @task)
#     end
#     assert_redirected_to category_path(@user.username, @category)
#   end

#   test "should reach toggle_complete controller action" do
#     assert_no_difference "Task.count" do
#       patch category_task_toggle_path(@user.username, @category, @task)
#     end
#     @same_task = Task.last
#     assert_not_equal @task.completed, @same_task.completed
#     assert_redirected_to category_task_path(@user.username, @category, @task)
#   end


#   # Restrictions
#   test "should not reach show, new, edit actions when not signed_in" do
#     sign_out(@user)

#     get category_task_path(@user.username, @category, @task)
#     assert_response :redirect 
#     assert_redirected_to new_user_session_path

#     get new_category_task_path(@user.username, @category)
#     assert_response :redirect 
#     assert_redirected_to new_user_session_path

#     get edit_category_task_path(@user.username, @category, @task)
#     assert_response :redirect 
#     assert_redirected_to new_user_session_path
#   end

#   test "should not reach show, new, edit actions of other accounts" do
#     get category_task_path("anotherAccount", @category, @task)
#     assert_response :redirect
#     assert_redirected_to dashboard_path(@user.username)

#     get new_category_task_path("anotherAccount", @category)
#     assert_response :redirect
#     assert_redirected_to dashboard_path(@user.username)

#     get edit_category_task_path("anotherAccount", @category, @task)
#     assert_response :redirect
#     assert_redirected_to dashboard_path(@user.username)
#   end
# end
