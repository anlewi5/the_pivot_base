require 'rails_helper'

RSpec.feature 'As an authenticated Store Admin' do
  scenario 'I can update business information' do
    user = create(:user)
    role = create(:store_admin)
    store_1 = create(:store, name: 'Ruby Moon Curiosities', status: 'active')
    store_2 = create(:store, name: 'Ollivanders', status: 'active')
    store_3 = create(:store, name: 'Weasleys Whizzies', status: 'active')
    user_role = create(:user_role, user: user, role: role, store: store_1)
    user_role = create(:user_role, user: user, role: role, store: store_2)
    user_role = create(:user_role, user: user, role: role, store: store_3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_index_path

    click_on "My Stores"

    expect(page).to have_content('Ruby Moon Curiosities')
    expect(current_path).to eq(user_stores_path)
    expect(page).to have_css('.store', count: 3)

    within(first('.store')) do
      click_on "Edit"
    end

    expect(current_path).to eq(edit_user_store_path(store_1))
    expect(page).to have_field('store[name]', with: 'Ruby Moon Curiosities')

    fill_in 'store[name]', with: "Stella's Coffee"

    click_on "Update"

    expect(current_path).to eq(user_stores_path)
    expect(page).to have_css('.store', count: 3)
  end
end