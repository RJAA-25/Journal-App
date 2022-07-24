class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  before_action :toggle_overdue, only: [:dashboard]

  def home
  end

  def dashboard
    if params[:username] == current_user.username
      @themes = color_array
      @categories = current_user.categories
      @tasks = current_user.tasks.where(completed: false).where(deadline: Date.current.all_day)
      @tasks_overdue = current_user.tasks.where(completed: false).where(overdue: true)
      # render :dashboard
    else
      flash[:alert] = "Forbidden action. You only have access to your account"
      redirect_to dashboard_path(current_user.username)
    end
  end
end
