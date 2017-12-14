require 'rails_helper'

RSpec.describe 'An unauthenticated platform admin' do
  let(:role) { create(:platform_admin) }
  let(:admin) { create(:admin) }

  it 'can visit the log in path and sign in' do
    admin.roles << role
    visit '/'

    expect(admin.roles).to include(role)

    click_on 'Login'

    expect(current_path).to eq('/login')
    expect(page).to have_content("Email")
    expect(page).to have_field('session[email]')
    expect(page).to have_content("Password")
    expect(page).to have_field('session[password]')

    fill_in 'session[email]', with: "#{admin.email}"
    fill_in 'session[password]', with: "#{admin.password}"

    click_button 'Login'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content("You're logged in as a Platform Admin.")
    expect(page).to have_content('Admin Dashboard')
  end
end