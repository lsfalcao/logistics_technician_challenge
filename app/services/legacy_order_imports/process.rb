class LegacyOrderImports::Process < ApplicationService
  def initialize(legacy_order_import)
    @legacy_order_import = legacy_order_import
    @line_errors = []
    begin
      @legacy_orders = LegacyOrder.load_lines(@legacy_order_import.file_current_path)
    rescue => e
      @legacy_order_import.update(results: e)
      @legacy_order_import.file.purge
    end
  end

  def call
    @legacy_orders.each_with_index do |legacy_order, index|
      create_by_line(legacy_order, index)
    end
    save_results
    purge_file
  end

  private

  def create_by_line(legacy_order, index)
    ActiveRecord::Base.transaction do
      user = User.find_or_create_by(
        legacy_id: legacy_order.user_id,
        name: legacy_order.user_name
      )
      order = Order.find_or_create_by(
        legacy_id: legacy_order.order_id,
        date: legacy_order.date,
        user_id: user.id
      )
      OrderProduct.find_or_create_by(
        legacy_product_id: legacy_order.product_id,
        value: legacy_order.value,
        order_id: order.id
      )
    rescue
      @line_errors << "Order couldn't be created with line #{index + 1}."
    end
  end

  def save_results
    message = "Total lines: #{@legacy_orders.count}\n"
    message << "Total errors: #{@line_errors.count}\n"
    message << @line_errors.join("\n")
    @legacy_order_import.update(results: message)
  end

  def purge_file
    @legacy_order_import.file.purge
  end
end
