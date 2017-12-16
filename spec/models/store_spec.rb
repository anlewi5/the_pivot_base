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

    describe "#update_status(status)" do
      it "changes the status of a pending store to active" do
        user = create(:user)
        registered_user_role = create(:registered_user)
        store_admin_role = create(:store_admin)

        user_roles = create(:user_role, user: user, role: registered_user_role, store: store)
        store.update_status("active")

        expect(store.status).to eq("active")
        expect(user.roles).to include(store_admin_role)
      end
    end
  end
end
