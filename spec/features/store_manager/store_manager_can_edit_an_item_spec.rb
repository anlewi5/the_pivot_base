require 'rails_helper'

feature "As a store manager" do
  let(:store_manager) { create(:user) }
  let(:store_manager_role) { create(:store_manager) }
  let(:store) { create(:store, status: "active") }
  let(:store_item) { create(:item, store: store) }

  scenario "I can change item information for a store that I manage" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(store_manager)
    create(:user_role, user: store_manager, role: store_manager_role, store: store)
    store_item

    visit admin_items_path
    expect(page).to have_content(store.name)

    click_on "Edit"

    fill_in "item[title]", with: "Learning Layups"
    fill_in "item[description]", with: "Improve your basketball skills"
    fill_in "item[price]", with: "12.09"
    page.attach_file("item[image]", testing_image)
    click_on "Update"

    expect(page).to have_content("Learning Layups")
    expect(page).to have_content("$12.09")
  end

  scenario "I don't see an item if it is not in a store I manage" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(store_manager)
    create(:user_role, user: store_manager, role: store_manager_role, store: store)
    store_item
    store_2 = create(:store, status: "active")
    store_item_2 = create(:item, store: store_2)

    visit admin_items_path

    expect(page).to have_content(store_item.title)
    expect(page).to_not have_content(store_item_2.title)
  end
end
