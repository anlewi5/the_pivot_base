namespace :order_items do
  desc "Save store_id on order_item records if not present"
  task save_store_info: :environment do
    OrderItem.find_each do |order_item|
      if order_item.store_id
        puts "order_item#{order_item.id} already has store_id."
      else
        store = order_item.store
        order_item.update(store: store)
        puts "order_item#{order_item.id} updated with store #{order_item.store_id}"
      end
    end
  end
end
