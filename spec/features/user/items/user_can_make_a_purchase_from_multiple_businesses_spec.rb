require 'rails_helper'

RSpec.feature "As a logged in user with items from different stores in my cart" do
  before :each do
    user = create(:user)
    registered_user_role = create(:registered_user)

    create(:user_role, user: user, role: registered_user_role)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    stores = create_list(:store, 2, status: "active")
    item_1 = create(:item, store: stores.first, price: 2.00)
    item_2 = create(:item, store: stores.last, price: 1.00)
    item_3 = create(:item, store: stores.last, price: 10.00)

    visit '/'
    click_on "Stores"
    click_on stores.first.name
    click_on "Add to cart"
    click_on "Stores"
    click_on stores.second.name
    click_link "Add to cart", href: "/carts?item_id=#{item_2.id}"
    click_link "Add to cart", href: "/carts?item_id=#{item_3.id}"
    click_on "Cart"
  end

  scenario "I can make a purchase" do
    click_on "Checkout"
    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order was successfully placed")
  end

  scenario "I make a purchase and see two orders on the page with the total price of each order" do
    click_on "Checkout"

    expect(page).to have_css(".order", count: 2)
    expect(page).to have_content("$2.00")
    expect(page).to have_content("$11.00")
  end
end
