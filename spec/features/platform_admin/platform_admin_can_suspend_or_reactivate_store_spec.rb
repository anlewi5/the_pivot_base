require 'rails_helper'

RSpec.feature "As a logged in platform admin" do
  feature "when I visit /admin/stores" do
    let(:store_admin_role) { create(:store_admin)}
    let(:platform_admin_role) { create(:platform_admin) }

    let(:user) { create(:user) }
    let(:platform_admin) { create(:user)}

    let(:store_1) { create(:store, status: "active") }
    let(:store_2) { create(:store, status: "suspended") }

    before(:each) do
      create(:user_role, user: user, role: store_admin_role, store: store_1)
      create(:user_role, user: user, role: store_admin_role, store: store_2)
      create(:user_role, user: platform_admin, role: platform_admin_role)
      platform_admin.roles << platform_admin_role

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)

      store_1
      store_2

      visit "/admin/stores"
    end

    scenario "I can change a store from active to suspended to take it offline" do
      within(".active_stores") do
        expect(page).to have_content(store_1.name)
        click_on "Suspend"
      end

      expect(current_path).to eq("/admin/stores")

      within(".suspended_stores") do
        expect(page).to have_content(store_1.name)
      end

      within(".active_stores") do
        expect(page).to_not have_content(store_1.name)
      end
    end

    scenario "I can change a store from suspended to activated to take it online" do
      within(".suspended_stores") do
        expect(page).to have_content(store_2.name)
        click_on "Reactivate"
      end

      expect(current_path).to eq("/admin/stores")

      within(".active_stores") do
        expect(page).to have_content(store_2.name)
      end

      within(".suspended_stores") do
        expect(page).to_not have_content(store_2.name)
      end
    end
  end
end
