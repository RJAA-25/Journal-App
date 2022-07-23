class CategoriesController < ApplicationController
  before_action :toggle_overdue, only: [:show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @tasks = @category.tasks
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:notice] = "Category created as \"#{@category.name}\""
      redirect_to category_path(current_user.username, @category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated as \"#{@category.name}\""
      redirect_to category_path(current_user.username, @category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "Category has been deleted"
    redirect_to dashboard_path(current_user.username), status: :see_other
  end


  private
  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :theme_color)
  end
end
