require 'rails_helper'

feature "As a logged in platform admin," do
  feature "when I visit /platform/dashboard and click 'Stores'" do
    let(:registered_user_role) { create(:registered_user) }
    let(:store_admin_role) { create(:store_admin) }
    let(:platform_admin_role) { create(:platform_admin) }

    let(:user) { create(:user) }
    let(:platform_admin) { create(:user) }

    let(:store_1) { create(:store, status: 0) }
    let(:store_2) { create(:store, status: 1) }
    let(:store_3) { create(:store, status: 2) }

    before(:each) do
      create(:user_role, user: user, role: registered_user_role, store: store_1)
      platform_admin.roles << platform_admin_role

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)

      visit "/platform/dashboard"
    end

    scenario  "I should see a list of stores divided by 'pending', 'active', and 'suspended' tabs" do
      store_2
      store_3
      click_link "All Stores", href: "/admin/stores"

      within(".pending_stores") do
        expect(page).to have_content(store_1.id)
        expect(page).to have_content(store_1.name)
        expect(page).to have_content(store_1.status.capitalize)
        expect(page).to have_link("Reject")
        expect(page).to have_link("Approve")
      end
      within(".active_stores") do
        expect(page).to have_content(store_2.id)
        expect(page).to have_content(store_2.name)
        expect(page).to have_content(store_2.status.capitalize)
        expect(page).to have_link("Suspend")
      end
      within(".suspended_stores") do
        expect(page).to have_content(store_3.id)
        expect(page).to have_content(store_3.name)
        expect(page).to have_content(store_3.status.capitalize)
        expect(page).to have_link("Reactivate")
      end
    end

    feature "When I click 'Approve' for the pending company" do
      scenario "it shows up in the 'active' tab, and the user that requested this store has a role of store admin" do
        store_admin_role
        click_link "All Stores", href: "/admin/stores"
        click_on "Approve"

        within(".active_stores") do
          expect(page).to have_content(store_1.id)
          expect(page).to have_content(store_1.name)
        end

        expect(user.roles).to include(store_admin_role)
      end
    end

    feature "When I click 'Reject' for the pending company" do
      scenario "it shows up in the 'suspended' tab, and the user that requested this store has a role of store admin" do
        store_admin_role
        click_link "All Stores", href: "/admin/stores"
        click_on "Reject"

        within(".suspended_stores") do
          expect(page).to have_content(store_1.id)
          expect(page).to have_content(store_1.name)
        end

        within(".active_stores") do
          expect(page).not_to have_content(store_1.id)
          expect(page).not_to have_content(store_1.name)
        end

        expect(user.roles).to include(store_admin_role)
      end
    end
  end
end
