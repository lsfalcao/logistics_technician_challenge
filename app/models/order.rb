class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :destroy
  accepts_nested_attributes_for :order_products

  validates :date, presence: true

  def total
    order_products.sum(:value)
  end
end
