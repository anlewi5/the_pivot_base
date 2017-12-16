require 'rails_helper'

RSpec.feature "As a logged in user when I visit a store" do
  context "with active and inactive items" do
    let(:user) { create(:user) }
    let(:role) { create(:registered_user) }

    scenario "I see a list of all active items and no inactive items" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user.roles << role

      store = create(:store, status: "active")
      item_1 = create(:item, store: store, condition: "active")
      item_2 = create(:item, store: store, condition: "active")
      item_3 = create(:item, store: store, condition: "retired")

      visit store_path(store.url)

      expect(page).to have_content(item_1.title)
      expect(page).to have_content(item_2.title)
      expect(page).to_not have_content(item_3.title)
    end

    context "and another store exists with active items" do
      scenario "I only see items from the current store and not the other store" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        user.roles << role

        store_1 = create(:store, status: "active")
        store_2 = create(:store, status: "active")
        item_1 = create(:item, store: store_1)
        item_2 = create(:item, store: store_2)

        visit store_path(store_1.url)

        expect(page).to have_content(item_1.title)
        expect(page).to_not have_content(item_2.title)
      end
    end
  end
end

# Background: There is an active company with a name of "Vandelay Industries" with 2 active items and 1 inactive item. There is also 1 item that isn't associated with this store.
#
# As a logged in user
# When I visit "/vandelay-industries"
# Then I should see a list of all active items for this store
# And I should not see inactive items or items for other stores
