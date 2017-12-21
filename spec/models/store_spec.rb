require 'rails_helper'

RSpec.describe Store do
  describe "#instance_methods" do
    let(:store) { create(:store) }

    describe "#active_items" do
      it "returns only active items" do
        item_1 = create(:item, store: store, condition: "active")
        item_2 = create(:item, store: store, condition: "retired")

        expect(store.active_items).to include(item_1)
        expect(store.active_items).to_not include(item_2)
      end
    end

    describe "#update_status(status, intial_req)" do
      context "a store has been requested" do
        it "changes the status of a pending store to active" do
          user = create(:user)
          registered_user_role = create(:registered_user)
          store_admin_role = create(:store_admin)

          user_roles = create(:user_role, user: user, role: registered_user_role, store: store)
          store.update_status("active", "true")

          expect(store.status).to eq("active")
          expect(user.roles).to include(store_admin_role)
        end

        it "changes the status of a pending store to suspended" do
          user = create(:user)
          registered_user_role = create(:registered_user)
          store_admin_role = create(:store_admin)

          user_roles = create(:user_role, user: user, role: registered_user_role, store: store)
          store.update_status("suspended", "true")

          expect(store.status).to eq("suspended")
          expect(user.roles).to include(store_admin_role)
        end
      end

      context "a store is active" do
        it "changes the status of an active store to suspended" do
          store_1 = create(:store, status: "active")
          user = create(:user)
          store_admin_role = create(:store_admin)

          create(:user_role, user: user, role: store_admin_role, store: store_1)

          store_1.update_status("suspended")

          expect(store_1.status).to eq("suspended")
        end
      end

      context "a store is suspended" do
        it "changes the status of a suspended store to active" do
          store_2 = create(:store, status: "suspended")
          user = create(:user)
          store_admin_role = create(:store_admin)

          create(:user_role, user: user, role: store_admin_role, store: store_2)

          store_2.update_status("active")

          expect(store_2.status).to eq("active")
        end
      end
    end
  end
end
