class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  before_action :toggle_overdue, only: [:dashboard]

  def home
  end

  def dashboard
    @themes = color_array
    @categories = Category.all
  end

end
