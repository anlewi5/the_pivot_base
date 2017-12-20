require "rails_helper"

describe "As a logged in Admin" do
  let(:admin) { create(:user, email: "admin@example.com")}
  let(:role) { create(:store_admin) }
  let(:platform) { create(:platform_admin) }

  it "I can modify my account data" do
    admin.roles << role

    login_user(admin.email, admin.password)

    new_email_address = "kramer@example.com"
    new_password      = "cosmo"

    visit admin_dashboard_index_path

    click_on "Update Account"
    fill_in "user[email]", with: new_email_address
    fill_in "user[password]", with: new_password
    click_on "Submit"

    click_on "Logout"
    login_user(new_email_address, new_password)
    expect(current_path).to eq("/platform/dashboard")
  end

  it "But I cannot modify any other user’s account data" do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
    user = create(:user, first_name: 'Emma')
    role = create(:registered_user)
    admin.roles << role
    user.roles << role

    visit dashboard_index_path(user)

    expect(page).not_to have_content('Emma')
    expect(page).to have_content('Gob')
  end

  it "returns a welcome message for admins" do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
    admin.roles << platform

    visit platform_dashboard_index_path
    expect(page).to have_content("You're logged in as a Platform Admin.")
  end

  it "returns a 404 when a non-admin visits the admin dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
    expect {
      visit admin_dashboard_index_path
    }.to raise_error(ActionController::RoutingError)
  end
end
