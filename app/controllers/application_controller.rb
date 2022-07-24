class ApplicationController < ActionController::Base

  def color_array
    ["#540D6E", "#9F86C0", "#C71F37",  "#E36414", "#3A5A40", "#6A994E", "#3F37C9", "#4895EF"] 
  end

  def toggle_overdue
    @tasks = current_user.tasks.where(completed: false).where("deadline < ?", DateTime.current)
    @tasks.update_all(overdue: true)
  end

  def restrict_account
    if params[:username] != current_user.username
      flash[:alert] = "Forbidden action. You only have access to your account."
      redirect_to dashboard_path(current_user.username)
    end
  end
end
