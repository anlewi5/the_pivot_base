require 'rails_helper'

RSpec.feature "As a store_admin" do
  let(:store_admin) { create(:user) }
  let(:store_admin_role) { create(:store_admin) }
  let(:store) { create(:store, status: "active") }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(store_admin)
    create(:user_role, user: store_admin, role: store_admin_role, store: store)
  end

  context "with two orders for my store" do
    let!(:order_1) { create(:order, status: "ordered", store: store) }
    let!(:order_2) { create(:order, status: "ordered", store: store) }

    it "I can change the status of orders" do
      visit admin_dashboard_index_path

      within(".order-#{order_2.id}") do
        click_on("Cancel")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-#{order_2.id}") do
        expect(page).to have_content("Cancelled")
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Paid")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Paid")
        end
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Completed")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Completed")
        end
      end
    end

    context "and an order for a different store" do
      scenario "I don't see the other store's order" do
        other_store = create(:store)
        other_order = create(:order, store: other_store)

        visit admin_dashboard_index_path

        expect(page).to have_css(".order-#{order_1.id}")
        expect(page).to_not have_css(".order-#{other_order.id}")
      end
    end
  end
end
