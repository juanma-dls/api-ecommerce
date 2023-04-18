class ProductsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_products, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    if @products != []
      render json: @products, status: :ok
    else
      render json: {
        status: { message: "No products found" }
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: @product, status: :ok
  end

  def create
    @product = Product.new(products_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity     
    end
  end

  def update
    @product.assign_attributes(products_params)
    if @product.update(products_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.deleted == false
      if @product.soft_delete
        render json: { message: "Product deleted successfully" }
      else
        render json: {
          status: { message: "The product could not be deleted" }
        }, status: :unprocessable_entity
      end
    else
      if @product.soft_delete
        render json: { message: "Product activated successfully" }
      else
        render json: {
          status: { message: "The product could not be activated" }
        }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_products
    @product = Product.find_by_id(params[:id])
  end

  def products_params
    params.require(:product).permit(:name, :description, :price, :deleted)
  end
end