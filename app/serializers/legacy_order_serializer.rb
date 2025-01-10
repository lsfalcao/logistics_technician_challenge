class LegacyOrderSerializer < ActiveModel::Serializer
  attributes :user_id, :name, :orders

  def user_id
    object.legacy_id
  end

  def orders
    object.orders.map do |order|
      {
        order_id: order.legacy_id,
        total: order.total,
        date: order.date,
        products: products(order)
      }
    end
  end

  def products(order)
    order.order_products.map do |order_product|
      {
        product_id: order_product.legacy_product_id,
        value: order_product.value
      }
    end
  end
end
