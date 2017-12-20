desc "Adds store to orders 1-55 which are the orders from the original store"
task associate_store_order: :environment do
  orders = Order.where(id: 1..55, store_id: nil)
  store = Store.find_by(name: "Little Shop of Funsies")

  orders.each do |order|
    if order.store
      puts "Order ##{order.id} already has a store."
    else
      order.update(store: store)
      puts "Order ##{order.id} now is associated to #{store.name} items."
    end
  end
end
