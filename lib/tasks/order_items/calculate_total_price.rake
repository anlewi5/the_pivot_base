namespace :order_items do
  desc "calculate total price for an order_item"
  task calculate_total_price: :environment do
    OrderItem.find_each do |order_item|
      total_price = order_item.quantity * order_item.unit_price
      order_item.update(total_price: total_price)
      puts "order_item#{order_item.id} total_price updated"
    end
  end
end
