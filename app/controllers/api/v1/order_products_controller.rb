class Api::V1::OrderProductsController < Api::AppController
  before_action :set_order_product, only: %i[show update destroy]

  # GET /order_products
  def index
    @order_products = OrderProduct.all

    render json: @order_products
  end

  # GET /order_products/1
  def show
    if stale?(last_modified: @order_product.updated_at)
      render json: @order_product
    end
  end

  # POST /order_products
  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.save
      render json: @order_product, status: :created
    else
      render json: @order_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_products/1
  def update
    if @order_product.update(order_product_params)
      render json: @order_product
    else
      render json: @order_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_products/1
  def destroy
    @order_product.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_product
    @order_product = OrderProduct.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_product_params
    params.require(:order_product).permit(:order_id, :product_id, :value)
  end
end
