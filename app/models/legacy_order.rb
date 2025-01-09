require "parseline"

class LegacyOrder
  attr_accessor :user_id, :user_name, :order_id, :product_id, :value, :date

  extend ParseLine::FixedWidth

  fixed_width_layout do |parse|
    parse.field :user_id, 0..9, lambda { |s| s.to_i }
    parse.field :user_name, 10..54
    parse.field :order_id, 55..64, lambda { |s| s.to_i }
    parse.field :product_id, 65..74, lambda { |s| s.to_i }
    parse.field :value, 75..86, lambda { |s| s.to_d }
    parse.field :date, 87..94, lambda { |s| s.to_date }
  end
end
