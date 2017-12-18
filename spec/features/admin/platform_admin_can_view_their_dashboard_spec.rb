require 'rails_helper'

RSpec.feature 'As an authenticated platform admin' do
  let(:role) { create(:platform_admin) }
  let(:admin) { create(:user) }

  scenario 'I can view my admin/dashboard' do
    admin.roles << role

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_index_path

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content('Admin Dashboard')
    expect(page).to have_content("You're logged in as a Platform Admin.")
  end
end