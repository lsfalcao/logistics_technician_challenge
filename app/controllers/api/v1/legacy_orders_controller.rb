class Api::V1::LegacyOrdersController < Api::AppController
  def index
    @users = User.includes(orders: :order_products).distinct

    # Users filters
    @users = @users.where(users: {legacy_id: params[:user_id]}) if params[:user_id].present?
    @users = @users.where("users.name LIKE ?", "%#{params[:user_name]}%") if params[:user_name].present?
    # Orders filters
    @users = @users.where(orders: {legacy_id: params[:order_id]}) if params[:order_id].present?
    if params[:order_start_date].present? && params[:order_end_date].present?
      @users = @users.where(orders: {date: params[:order_start_date].to_date..params[:order_end_date].to_date})
    end
    if params[:min_order_total].present? && params[:max_order_total].present?
      @users = @users.where(orders: {total: params[:min_order_total].to_d..params[:max_order_total].to_d})
    end
    # order_products filters
    @users = @users.where(order_products: {legacy_product_id: params[:product_id]}) if params[:product_id].present?

    render json: ActiveModel::Serializer::CollectionSerializer.new(@users, serializer: LegacyOrderSerializer)
  end
end
