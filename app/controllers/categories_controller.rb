class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created as \"#{@category.name}\""
      redirect_to categories_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated as \"#{@category.name}\""
      redirect_to categories_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.delete
    redirect_to categories_path
  end


  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, :theme_color)
  end
end
