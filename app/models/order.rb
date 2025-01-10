class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :destroy

  validates :date, presence: true

  def calc_total
    update_column(:total, order_products.sum(:value))
  end
end
