namespace :orders do
  desc "populates info on order_items before finding total_price for orders"
  task all_tasks_for_total_price: [:environment, "order_items:populate_unit_price", "order_items:calculate_total_price", "orders:calculate_total_price"]
end
