require 'rails_helper'

RSpec.feature "As a logged in user with items from different stores in my cart" do
  before :each do
    user = create(:user)
    registered_user_role = create(:registered_user)

    create(:user_role, user: user, role: registered_user_role)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    stores = create_list(:store, 2, status: "active")
    create(:item, store: stores.first)
    create(:item, store: stores.last)

    visit '/'
    click_on "Stores"
    click_on stores.first.name
    click_on "Add to cart"
    click_on "Stores"
    click_on stores.second.name
    click_on "Add to cart"
    click_on "Cart"
  end

  scenario "I can make a purchase" do
    click_on "Checkout"
    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order was successfully placed")
  end
end
