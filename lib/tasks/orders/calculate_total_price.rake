namespace :orders do
  desc "Calculate total price for an order through order_items"
  task calculate_total_price: :environment do
    Order.find_each do |order|
      order.update(total_price: order.order_items.sum(:total_price))
      puts "Order#{order.id} total_price updated"
    end
  end
end
