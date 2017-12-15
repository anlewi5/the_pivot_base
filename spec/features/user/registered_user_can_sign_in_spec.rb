require 'rails_helper'

RSpec.feature 'An unauthenticated registered user' do
  let(:user) { create(:user) }
  let(:role) { create(:registered_user) }

  scenario 'can visit the log in path and sign in' do
    user.roles << role

    visit login_path

    expect(current_path).to eq('/login')

    fill_in 'session[email]', with: "#{user.email}"
    fill_in 'session[password]', with: "#{user.password}"

    click_button 'Login'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{user.full_name}.")
    expect(page).to have_content('Dashboard')
  end
end