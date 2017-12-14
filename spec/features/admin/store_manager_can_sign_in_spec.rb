require 'rails_helper'

RSpec.describe 'An authenticated store manager' do
  let(:admin) { create(:admin) }
  let(:role) { create(:store_manager) }

  it 'can visit the log in path and sign in' do
    admin.roles << role
    expect(admin.roles).to include(role)

    visit login_path

    expect(current_path).to eq('/login')
    expect(page).to have_content("Email")
    expect(page).to have_field('session[email]')
    expect(page).to have_content("Password")
    expect(page).to have_field('session[password]')

    fill_in 'session[email]', with: admin.email
    fill_in 'session[password]', with: admin.password

    click_button 'Login'

    expect(current_path).to eq(admin_dashboard_index_path)
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("You're logged in as a Store Manager.")
  end
end