class PagesController < ApplicationController
  
  def home
    
  end

  def dashboard
    @themes = color_array
    @categories = Category.all
  end

end
