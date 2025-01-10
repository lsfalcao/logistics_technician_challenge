class OrderProduct < ApplicationRecord
  belongs_to :order

  validates :value, :legacy_product_id, presence: true

  after_save :calc_order_total

  private

  def calc_order_total
    order.calc_total if saved_change_to_value?
  end
end
