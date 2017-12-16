require 'rails_helper'

describe "As a guest, when I visit '/store-name-1'" do
  it "I see the store name, a list of all items associated to that store, and each items name, price, and 'Add to Cart' button." do
    stores = create_list(:store, 2, status: "active")
    items_store_1 = create_list(:item, 2, store: stores.first)
    items_store_2 = create_list(:item, 2, store: stores.last, price: 11.00)

    visit store_path(store: stores.first.url)

    expect(current_path).to eq("/#{stores.first.url}")

    expect(page).to have_content(stores.first.name)

    items_store_1.each do |item|
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.price)
      expect(page).to have_link("Add to cart")
    end

    items_store_2.each do |item|
      expect(page).not_to have_content(item.title)
      expect(page).not_to have_content(item.price)
    end
  end
end
