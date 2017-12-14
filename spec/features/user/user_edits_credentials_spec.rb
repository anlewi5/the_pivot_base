require 'rails_helper'

RSpec.describe 'As a registered user' do
  let(:user) { create(:user) }

  it 'I can edit my credentials without a password' do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)

    visit ("/account/edit")

    name = user.first_name

    expect(page).to have_field('user[first_name]')
    expect(find_field('user[first_name]').value).to eq(user.first_name)
    expect(page).to have_field('user[last_name]')
    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[address]')

    fill_in "user[first_name]", with: "George Oscar Bluth"
save_and_open_page
    click_on "Submit"
save_and_open_page
    expect(current_path).to eq(edit_user_path)
    expect(find_field('user[first_name]').value).to eq('George Oscar Bluth')
    expect(find_field('user[first_name]').value).not_to eq(name)
    expect(page).to have_content("Successfully updated your account information.")
  end
end