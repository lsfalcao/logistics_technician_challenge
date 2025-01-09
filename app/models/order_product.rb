class OrderProduct < ApplicationRecord
  belongs_to :order

  validates :value, :legacy_product_id, presence: true
end
