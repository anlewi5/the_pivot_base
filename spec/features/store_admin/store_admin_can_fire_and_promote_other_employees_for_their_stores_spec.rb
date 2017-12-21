require 'rails_helper'

RSpec.describe "As a store admin, I have a 'Manage Employees' page" do
  before(:each) do
    @store_admin_1 = create(:user)
    @store_admin_2 = create(:user)
    @store_manager_1 = create(:user)

    @store_admin_role = create(:store_admin)
    @store_manager_role = create(:store_manager)

    @store_1 = create(:store, name: "Onesies")
    @store_2 = create(:store, name: "Books and Stuff")

    create(:user_role, user: @store_admin_1, role: @store_admin_role, store: @store_1)
    create(:user_role, user: @store_admin_1, role: @store_admin_role, store: @store_2)

    create(:user_role, user: @store_admin_2, role: @store_admin_role, store: @store_1)
    create(:user_role, user: @store_manager_1, role: @store_manager_role, store: @store_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@store_admin_1)

    visit admin_dashboard_index_path
    click_on "Manage Employees"
  end

  it "that displays all the stores I'm associated with, as well as employee information for each" do
    within ".#{@store_1.url}" do
      expect(page).to have_content(@store_1.name)
      expect(page).to have_content("#{@store_admin_1.first_name} #{@store_admin_1.last_name}")
      expect(page).to have_content("#{@store_admin_2.first_name} #{@store_admin_2.last_name}")
      expect(page).to have_content("#{@store_manager_1.first_name} #{@store_manager_1.last_name}")

      expect(page).to have_link("Promote", count: 1)
      expect(page).to have_link("Fire", count: 3)
    end

    within ".#{@store_2.url}" do
      expect(page).to have_content(@store_2.name)
      expect(page).to have_content("#{@store_admin_1.first_name} #{@store_admin_1.last_name}")
    end
  end

  it "I can 'Fire' the other store admin and remain on the Manage Employees page" do
    click_link 'Fire', href: admin_employee_path(@store_admin_2, store_id: @store_1.id, fire: true)

    within ".#{@store_1.url}" do
      expect(page).to have_content("#{@store_admin_1.first_name} #{@store_admin_1.last_name}")
      expect(page).not_to have_content("#{@store_admin_2.first_name} #{@store_admin_2.last_name}")
      expect(page).to have_content("#{@store_manager_1.first_name} #{@store_manager_1.last_name}")

      expect(page).to have_link("Promote", count: 1)
      expect(page).to have_link("Fire", count: 2)
    end

    expect(current_path).to eq(admin_employees_path)
  end

  it "I can 'Promote' the store manager to store admin" do
    click_link 'Promote'

    expect(@store_manager_1.roles).to include(@store_admin_role)
    expect(page).to have_content("Store Admin", count: 4)
  end
end
