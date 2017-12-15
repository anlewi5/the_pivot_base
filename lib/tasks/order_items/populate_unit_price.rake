namespace :order_items do
  desc "Retrieve the unit_price for an order_item from it's item"
  task populate_unit_price: :environment do
    OrderItem.find_each do |order_item|
      order_item.update(unit_price: order_item.item.price)
      puts "order_item#{order_item.id} unit_price updated"
    end
  end
end
