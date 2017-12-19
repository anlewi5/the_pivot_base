require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a status' do
        order = build(:order, status: nil)
        expect(order).to be_invalid
      end

    end
    describe 'valid attributes' do
      it 'is valid' do
        order = build(:order)
        expect(order).to be_valid
      end
    end
  end
  describe 'relationships' do
    it 'belongs to a user' do
      order = build(:order)
      expect(order).to respond_to(:user)
    end

    it 'has many items' do
      item = create(:item)
      order = build(:order, items: [item])
      expect(order).to respond_to(:items)
      expect(order.items.first).to be_an(Item)
    end
  end

  describe "instance methods" do
    it "can return total price of the order" do
      user = create(:user)
      store = create(:store)
      item_1 = create(:item, title: "Dove", price: 10.00, store: store)
      item_2 = create(:item, title: "Seal", price: 1.00, store: store)

      item_hash = {}
      item_hash[item_1] = 1
      item_hash[item_2] = 1
      orders = OrderCreationService.create_from_cart(item_hash, user)
      order = orders.first

      expect(order.total_price).to eq(11.0)
    end

    context "order price should not change when an item price changes" do
      it "returns correct total_price after an item price changes" do
        user = create(:user)
        item = create(:item, title: "Dove", price: 10.00)

        item_hash = {}
        item_hash[item] = 1
        orders = OrderCreationService.create_from_cart(item_hash, user)
        order = orders.first

        expect(order.total_price).to eq(10.00)

        item.update(price: 12.00)

        expect(order.total_price).to eq(10.00)
        expect(order.total_price).to_not eq(12.00)
      end
    end

    it "can return the order date" do
      order = create(:order, created_at: "2017-09-13 01:13:04 -0600")

      expect(order.date).to eq("Sep. 13, 2017")
    end
  end

  describe ".class.methods" do
    it "can count by status" do
      create(:order, status: "ordered")
      create(:order, status: "ordered")
      create(:order, status: "paid")
      create(:order, status: "cancelled")

      status_count = {"paid"=>1, "ordered"=>2, "cancelled"=>1}

      expect(Order.count_by_status).to eq(status_count)
    end

    describe ".filter_by_status(status, user)" do
      it "returns the order by status" do
        user = create(:user)
        role = create(:platform_admin)
        create(:user_role, user: user, role: role)

        ordered   = create(:order, status: "ordered")
        paid_1    = create(:order, status: "paid")
        paid_2    = create(:order, status: "paid")
        cancelled = create(:order, status: "cancelled")

        all_ordered   = Order.filter_by_status("ordered", user)
        all_paid      = Order.filter_by_status("paid", user)
        all_cancelled = Order.filter_by_status("cancelled", user)

        expect(all_ordered).to include(ordered)
        expect(all_ordered.count).to eq(1)

        expect(all_paid).to include(paid_1)
        expect(all_paid).to include(paid_2)
        expect(all_paid.count).to eq(2)

        expect(all_cancelled).to include(cancelled)
        expect(all_cancelled.count).to eq(1)
      end
    end

    describe ".all_for_admin(user)" do
      it "returns all orders for a platform_admin" do
        store = create(:store)
        orders = create_list(:order, 3, store: store)
        platform_admin = create(:user)
        platform_admin_role = create(:platform_admin)
        create(:user_role, user: platform_admin, role: platform_admin_role)

        expect(Order.all_for_admin(platform_admin)).to eq(orders)
      end

      it "returns orders associated with a store_admin/store_manager and does not return other items" do
        stores = create_list(:store, 2)
        orders_store1 = create_list(:order, 2, store: stores.first)
        order_store2 = create(:order, store: stores.last)
        store_admin = create(:user)
        store_admin_role = create(:store_admin)
        create(:user_role, user: store_admin, role: store_admin_role, store: stores.first)

        expect(Order.all_for_admin(store_admin)).to include(orders_store1.first)
        expect(Order.all_for_admin(store_admin)).to include(orders_store1.last)
        expect(Order.all_for_admin(store_admin)).to_not include(order_store2)
      end
    end
  end
end
