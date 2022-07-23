class TasksController < ApplicationController
  before_action :toggle_overdue, only: [:show]
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  after_action :reset_overdue, only: [:update]

  def show
  end

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task has been added"
      redirect_to category_task_path(current_user.username, @category, @task)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Task has been updated successfully"
      redirect_to category_task_path(current_user.username, @category, @task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:alert] = "Task has been removed successfully"
    redirect_to category_path(current_user.username, @category), status: :see_other
  end

  def toggle
    @task.completed = !@task.completed
    @task.save(validate: false)
    msg = "Task marked "
    @task.completed ? msg += "complete" : msg += "incomplete"
    flash[:notice] = msg
    redirect_to category_task_path(current_user.username, @category, @task), status: :see_other
  end


  private
  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def reset_overdue
    @task.update(overdue: false);
  end

  def task_params
    params.require(:task).permit(:name, :details, :deadline, :completed, :overdue)
  end
end
