class CategoriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_category, only: [:show, :update, :logical_deletion]

  def index
    @categories = Category.all
    if @categories != [ ]
    render json: @categories, status: :ok
    else
      render json: {
        status: {message: "No categories found"}
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: @category, status: :ok
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def logical_deletion
    @category.assign_attributes(params.require(:category).permit(:deleted))
    if @category.update(category)
      render json: @category, status: :ok
    else
      render json: {
        status: {message: "The category could not be deleted"}
      }, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find_by_id(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
  
end
