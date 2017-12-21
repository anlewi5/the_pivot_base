require 'rails_helper'

RSpec.feature "As a visitor, when I visit /stores" do
  before :each do
    @store_1 = create(:store, status: "active")
    @store_2 = create(:store, status: "active")
  end

  scenario "I see all stores" do
    visit stores_path

    expect(current_path).to eq("/stores")

    expect(page).to have_content(@store_1.name)
    expect(page).to have_content(@store_2.name)
  end

  context "with 2 active stores, 1 pending store, and 1 suspended store" do
    scenario "I only see the active stores" do
      store_3 = create(:store, status: "pending")
      store_4 = create(:store, status: "suspended")

      visit stores_path

      expect(page).to have_content(@store_1.name)
      expect(page).to have_content(@store_2.name)
      expect(page).to_not have_content(store_3.name)
      expect(page).to_not have_content(store_4.name)
    end
  end

  context "and there are two stores that both have items" do
    scenario "I only see store info, and I don't see any items" do
      item_1 = create(:item, store: @store_1)
      item_2 = create(:item, store: @store_2)

      visit stores_path

      expect(page).to have_content(@store_1.name)
      expect(page).to_not have_content(item_1.title)
      expect(page).to_not have_content(item_2.title)
    end
  end
end
