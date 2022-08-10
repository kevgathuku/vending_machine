class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]
  before_action :authenticate_request, only: %i[create update destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if @product.save
      render :show, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    unless @product.seller == @current_user
      render json: { error: 'Invalid user' }, status: :unauthorized and return
    end

    if @product.update(product_params)
      render :show, status: :ok, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    unless @product.seller == @current_user
      render json: { error: 'Invalid user' }, status: :unauthorized and return
    end

    @product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :amount_available, :price, :seller_id)
  end
end
