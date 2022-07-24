class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  before_action :restrict_account, except: [:home]
  before_action :toggle_overdue, only: [:dashboard]

  def home
  end

  def dashboard
    @themes = color_array
    @categories = current_user.categories
    @tasks = current_user.tasks.where(completed: false).where(deadline: Date.current.all_day)
    @tasks_overdue = current_user.tasks.where(completed: false).where(overdue: true)
  end

  def profile
    @user = current_user
  end
end
