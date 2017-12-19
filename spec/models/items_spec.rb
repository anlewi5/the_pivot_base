require 'rails_helper'

describe Item do
  let(:category) { build(:category, title: "Animals") }

  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a title' do
        item = build(:item, title: nil)
        expect(item).to be_invalid
      end

      it 'is invalid without a description' do
        item = build(:item, description: nil)
        expect(item).to be_invalid
      end

      it 'is invalid without a price' do
        item = build(:item, price: nil)
        expect(item).to be_invalid
      end

      it 'is valid without a image' do
        item = build(:item, image: nil)
        expect(item).to be_valid
      end

      it 'is invalid without a unique title' do
        persisted_valid_item = create(:item, title: "Funsie Onesie")
        invalid_item = build(:item, title: "Funsie Onesie")
        expect(invalid_item).to be_invalid
        expect(invalid_item.errors.full_messages).to include("Title has already been taken")
      end
    end

    describe 'valid attributes' do
      it 'condition is active if not specified' do
        item = build(:item)
        expect(item.condition).to eq('active')
      end

      it 'condition can be set to retired' do
        item = build(:item, condition: "retired")
        expect(item.condition).to eq('retired')
      end
    end
  end

  describe "relationships" do
    it "belongs to a category" do
      item = build(:item)
      expect(item).to respond_to(:category)
    end

    it "has many orders" do
      item = build(:item)
      expect(item).to respond_to(:orders)
    end
  end

  describe ".class_methods" do
    describe ".all_for_admin(user)" do
      it "returns all items for a platform_admin" do
        store = create(:store)
        items = create_list(:item, 3, store: store)
        platform_admin = create(:user)
        platform_admin_role = create(:platform_admin)
        create(:user_role, user: platform_admin, role: platform_admin_role)

        expect(Item.all_for_admin(platform_admin)).to include(items.first)
        expect(Item.all_for_admin(platform_admin)).to include(items[1])
        expect(Item.all_for_admin(platform_admin)).to include(items.last)
      end

      it "returns items associated with a store_admin/store_manager and does not return other items" do
        stores = create_list(:store, 2)
        items_store1 = create_list(:item, 2, store: stores.first)
        item_store2 = create(:item, store: stores.last)
        store_admin = create(:user)
        store_admin_role = create(:store_admin)
        create(:user_role, user: store_admin, role: store_admin_role, store: stores.first)

        expect(Item.all_for_admin(store_admin)).to include(items_store1.first)
        expect(Item.all_for_admin(store_admin)).to include(items_store1.last)
        expect(Item.all_for_admin(store_admin)).to_not include(item_store2)
      end
    end
  end
end
