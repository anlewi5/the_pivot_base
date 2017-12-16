require 'rails_helper'

RSpec.describe Store do
  describe "#instance_methods" do
    describe "#active_items" do
      let(:store) { create(:store) }

      it "returns only active items" do
        item_1 = create(:item, store: store, condition: "active")
        item_2 = create(:item, store: store, condition: "retired")

        expect(store.active_items).to include(item_1)
        expect(store.active_items).to_not include(item_2)
      end
    end
  end
end
