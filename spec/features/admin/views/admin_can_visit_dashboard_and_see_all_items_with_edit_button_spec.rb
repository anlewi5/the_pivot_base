require 'rails_helper'

RSpec.describe 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      store = create(:store, status: "active")
      admin_user = create(:user)
      role = create(:store_manager)
      create(:user_role, user: admin_user, role: role, store: store)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

      category = create(:category)
      items = create_list(:item, 2, category: category, store: store)
      item_one = items.first
      item_two = items.last

      visit admin_dashboard_index_path

      click_on "My Items"

      expect(page).to have_content(item_one.title)
      expect(page).to have_content(item_one.price)
      expect(page).to have_content(item_two.title)
      expect(page).to have_content(item_two.price)
      expect(page).to have_content("Edit")
    end
  end
end
