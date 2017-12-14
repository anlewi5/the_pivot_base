require 'rails_helper'

describe "As a guest, when I visit '/store-name-1'" do
  it "I see the store name, a list of all items associated to that store, and each items name, stock image, price, and 'Add to Cart' button." do
    stores = create_list(:store, 2)
    items_store_1 = create_list(:item, 2, store: stores.first)
    items_store_2 = create_list(:item, 2, store: stores.last)

    visit store_path(stores.first)

    expect(current_path).to eq("/#{stores.first.name}")

    items_store_1.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_css("imgasdfasdfsadf")
      expect(page).to have_content(item.price)
      expect(page).to have_content("check for button ")
    end
  end
end
