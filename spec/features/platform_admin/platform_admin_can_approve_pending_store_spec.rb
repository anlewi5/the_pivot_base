require 'rails_helper'

feature "As a logged in platform admin," do
  feature "when I visit /admin/dashboard and click 'Stores'" do

    before(:each) do
      registered_user_role = create(:registered_user)
      @store_admin = create(:store_admin)
      platform_admin_role = create(:platform_admin)

      @user = create(:user)
      @store_1 = create(:store, status: 0)
      create(:user_role, user: @user, role: registered_user_role, store: @store_1)

      platform_admin = create(:user)
      platform_admin.roles << platform_admin_role

      @store_2 = create(:store, status: 1)
      @store_3 = create(:store, status: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)

      visit "/admin/dashboard"
      click_on "Stores"
    end

    scenario  "I should see a list of stores divided by 'pending', 'active', and 'suspended' tabs" do
      within(".pending_stores") do
        expect(page).to have_content(@store_1.id)
        expect(page).to have_content(@store_1.name)
        expect(page).to have_content(@store_1.status.capitalize)
        expect(page).to have_link("Reject")
        expect(page).to have_link("Approve")
      end
      within(".active_stores") do
        expect(page).to have_content(@store_2.id)
        expect(page).to have_content(@store_2.name)
        expect(page).to have_content(@store_2.status.capitalize)
        expect(page).to have_link("Suspend")
      end
      within(".suspended_stores") do
        expect(page).to have_content(@store_3.id)
        expect(page).to have_content(@store_3.name)
        expect(page).to have_content(@store_3.status.capitalize)
        expect(page).to have_link("Reactivate")
      end
    end

    feature "When I click 'Approve' for the pending company" do
      scenario "it shows up in the 'active' tab, and the user that requested this store has a role of store admin" do
        click_on "Approve"

        within(".active_stores") do
          expect(page).to have_content(@store_1.id)
          expect(page).to have_content(@store_1.name)
        end

        expect(@user.roles).to include(@store_admin)
      end
    end
  end
end
