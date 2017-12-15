namespace :order_items do
  desc "Retrieve the unit_price for an order_item from it's item"
  task populate_unit_price: :environment do
    OrderItem.find_each do |order_item|
      if !order_item.unit_price
        order_item.update(unit_price: order_item.item.price)
        puts "order_item#{order_item.id} unit_price updated"
      else
        puts "order_item#{order_item.id}PRICE ALREADY POPULATED"
      end
    end
  end
end
