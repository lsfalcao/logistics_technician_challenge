class OrderProduct < ApplicationRecord
  belongs_to :order

  validates :value, :product_id, presence: true
end
