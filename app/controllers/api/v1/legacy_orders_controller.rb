class Api::V1::LegacyOrdersController < Api::AppController
  def index
    @users = User.includes(orders: :order_products)

    render json: ActiveModel::Serializer::CollectionSerializer.new(@users, serializer: LegacyOrderSerializer)
  end
end
