class ApplicationController < ActionController::Base

  def color_array
    ["#540D6E", "#9F86C0", "#C71F37",  "#E36414", "#3A5A40", "#6A994E", "#3F37C9", "#4895EF"] 
  end

  def toggle_overdue
    @tasks = Task.where(completed: false).where("deadline < ?", DateTime.now)
    @tasks.update_all(overdue: true)
  end
  
end
