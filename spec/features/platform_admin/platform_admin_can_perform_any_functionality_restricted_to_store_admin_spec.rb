require 'rails_helper'

RSpec.feature 'As an authenticated Platform Admin' do
  describe 'I can perform any functionality restricted to Store admin' do
    let(:admin) { create(:user) }
    let(:platform_admin_role) { create(:platform_admin) }
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:store_admin_role) { create(:store_admin) }

    let(:store_1) { create(:store, name: "Stella's Tea", status: 1) }
    let(:store_2) { create(:store, name: "Ollivander's", status: 1) }
    let(:admin_role) { create(:user_role, user: admin, role: platform_admin_role) }
    let(:user_role_1) { create(:user_role, user: user_1, role: store_admin_role, store: store_1) }
    let(:user_role_2) { create(:user_role, user: user_2, role: store_admin_role, store: store_2) }
    let(:stella_item) { create(:item, store: store_1) }
    let(:ollivander_item) { create(:item, store: store_2) }

    let(:order_1) { create(:order, store: store_1, user: user_1) }
    let(:order_2) { create(:order, store: store_1, user: user_2) }
    let(:order_3) { create(:order, store: store_2, user: user_2) }

    let(:order_item_1) { create(:order_item, order: order_1, item: stella_item) }
    let(:order_item_2) { create(:order_item, order: order_2, item: stella_item) }
    let(:order_item_3) { create(:order_item, order: order_3, item: ollivander_item) }

    before :each do
      admin
      user_1
      user_2

      platform_admin_role
      store_admin_role

      store_1
      store_2

      admin_role
      user_role_1
      user_role_2

      stella_item
      ollivander_item

      order_1
      order_2
      order_3

      order_item_1
      order_item_2
      order_item_3

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    scenario 'and view every order' do
      visit platform_orders_path

      expect(current_path).to eq('/platform/orders')
      expect(page).not_to have_content('Cancelled')
      expect(page).to have_content('Cancel', count: 3)
      expect(page).to have_content('Mark as Completed', count: 3)

      within(".order-#{order_1.id}") do
        click_on 'Cancel'
      end

      expect(current_path).to eq('/platform/orders')
      within(".order-#{order_1.id}") do
        expect(page).to have_content('Cancelled')
      end
      expect(page).to have_content('Mark as Completed', count: 2)
    end

    scenario 'and change the status of every store' do
      visit admin_stores_path

      expect(current_path).to eq('/admin/stores')
      expect(page).to have_content("Stella's Tea")
      expect(page).to have_content("Ollivander's")
      expect(page).not_to have_content('Reactivate')
      within(".store#{store_1.id}") do
        expect(page).to have_content('Active')
        expect(page).to have_link('Suspend')
      end

      within(".store#{store_1.id}") do
        click_on 'Suspend'
      end

      expect(current_path).to eq('/admin/stores')
      within(".store#{store_1.id}") do
        expect(page).to have_link('Reactivate')
      end
    end


    scenario 'and edit every item' do
      visit platform_items_path

      expect(current_path).to eq('/platform/items')

      expect(page).to have_content(stella_item.title)
      expect(page).to have_content(ollivander_item.title)
      expect(page).to have_css('.card-body', count: 2)
      expect(page).not_to have_content("Stella Tea")

      within(first('.card-body')) do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_platform_item_path(stella_item))

      fill_in 'item[title]', with: 'Stella Tea'

      click_on 'Update Item'
      expect(current_path).to eq(platform_items_path)
      expect(page).to have_content("Stella Tea")
    end

    scenario 'and view/edit every user' do
      visit platform_users_path

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_2.name)
      expect(page).not_to have_content('Stella')
      within(".user#{user_1.id}") do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_platform_user_path(user_1))

      fill_in 'user[name]', with: "Stella"
      click_on 'Update'

      expect(current_path).to eq(platform_users_path)
      expect(page).to have_content('Stella')
    end

    scenario 'and change roles' do
      visit edit_platform_user_path(user_1)

    end

    scenario 'and alter their associations' do

    end
  end
end