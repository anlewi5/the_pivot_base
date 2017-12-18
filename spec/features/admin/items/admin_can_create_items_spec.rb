require 'rails_helper'

RSpec.feature "Admin item creation" do
  let(:admin) { create(:user) }
  let(:role) { create(:store_admin) }
  let(:store) { create(:store) }
  let(:category) { create(:category) }

  before :each do
    store
    category
  end

  context "As an authenticated admin" do
    it "I can create an item" do
      create(:user_role, user: admin, role: role, store: store)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_items_path
      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      select store.name, from: "item[store_id]"
      select category.title, from: "item[category_id]"
      page.attach_file("item[image]", testing_image)
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    it "I can create an item without an image and it defaults" do
      create(:user_role, user: admin, role: role, store: store)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_items_path

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      select store.name, from: "item[store_id]"
      select category.title, from: "item[category_id]"
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
  end
end
