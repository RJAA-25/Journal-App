class PagesController < ApplicationController
  
  def home
    
  end

  def dashboard
    @categories = Category.all
  end

end
