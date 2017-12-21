require 'rails_helper'

RSpec.feature 'As a logged in user when I visit /stores/new' do
  let(:user) { create(:user) }
  let(:role) { create(:registered_user) }

  feature 'And I fill in the name field with "Vandelay Industries" and I click submit' do
    scenario 'I should be on /dashboard' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      user.roles << role

      visit new_store_path

      expect(current_path).to eq('/stores/new')

      fill_in 'store[name]', with: 'Vandelay Industries'

      click_on 'Submit'

      store = Store.find_by(name: 'Vandelay Industries')

      expect(store.status).to eq("pending")
      expect(store.url).to eq("vandelay-industries")

      expect(page).to have_content("You have successfully requested the creation of a new store, #{store.name}!")
      expect(current_path).to eq('/dashboard')
      expect(page).to have_link('My Stores')

      click_on 'My Stores'

      expect(page).to have_content('Vandelay Industries')
      expect(page).to have_content('pending')
    end
  end
end
