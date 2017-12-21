require 'rails_helper'

feature "As a guest, I can add items from multiple stores to my cart" do
  it "which will display each item in the cart page" do
    stores = create_list(:store, 2, status: "active")
    item_store_1 = create(:item, store: stores.first)
    item_store_2 = create(:item, store: stores.last)

    visit '/'
    click_on "Stores"
    click_on stores.first.name
    click_on "Add to cart"
    click_on "Stores"
    click_on stores.second.name
    click_on "Add to cart"
    click_on "Cart"

    expect(page).to have_content(item_store_1.title)
    expect(page).to have_content(item_store_2.title)
  end
end
