class OrderCreationService
  def self.create_from_cart(cart_contents, user)
    store_groups = group_cart_by_store(cart_contents).values
    create_orders(store_groups, user)
  end

  private

    def self.group_cart_by_store(cart_contents)
      cart_contents.group_by do |item_info|
        item_info.first.store.id
      end
    end

    def self.create_orders(orders_data, user)
      orders_data.map do |order_details|
        order = Order.create(status: "ordered", user: user)
        create_order_items(order, order_details)
        order.update_total_price
        order
      end
    end

    def self.create_order_items(order, order_details)
      order_details.each do |order_item_details|
        item = order_item_details[0]
        quantity = order_item_details[1]
        unit_price = item.price
        total_price = unit_price * quantity

        OrderItem.create(order: order,
          item: item,
          quantity: quantity,
          unit_price: unit_price,
          total_price: total_price)
      end
    end
end
