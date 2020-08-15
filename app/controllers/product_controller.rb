class ProductController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:index_candies, :index_food]

  # POST /product
  def create
    @product = Product.create!(product_params)
    render json: @product, status: :created
  end
  
  # GET /product
  def index
    @products = Product.where(available: true)
    render json: @products, status: :ok
  end

  # GET /candies
  def index_candies
    @candies_products = Product.only_candies
    render json: @candies_products, status: :ok
  end

  # GET /food
  def index_food
    @food = Product.only_food
    render json: @food, status: :ok
  end

  # GET /product/{id}
  def show
    @product = Product.find(params[:id])
    render json: @product, status: :ok
  end

  # PUT /product/{id}
  def update
    @product = Product.find(params[:id])
    @product.update!(product_params)
    render json: @product, status: :ok
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :quantity, :type_product_id, :presentation_product_id, :available, :image_product)
  end
end
