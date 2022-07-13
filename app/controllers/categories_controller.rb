class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  
  # def index
  #   @categories = Category.all
  # end

  def show
    @tasks = @category.tasks
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created as \"#{@category.name}\""
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated as \"#{@category.name}\""
      redirect_to category_path(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "Category has been deleted"
    redirect_to dashboard_path, status: :see_other
  end


  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :theme_color)
  end
end
