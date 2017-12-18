require 'rails_helper'

describe OrderCreationService do
  context "Class Methods" do
    context ".create_from_cart(cart_contents, user)" do
      it "returns an array of Orders and creates their corresponding order_items" do
        user = create(:user)
        stores = create_list(:store, 2)
        item_1 = create(:item, title: "Dove", price: 10.00, store: stores.first)
        item_2 = create(:item, title: "Seal", price: 1.00, store: stores.second)

        item_hash = {}
        item_hash[item_1] = 1
        item_hash[item_2] = 1
        orders = OrderCreationService.create_from_cart(item_hash, user)

        orders.each do |order|
          expect(order).to be_a Order
          expect(order.order_items.count).to eq(1)
        end
      end
    end
  end
end
