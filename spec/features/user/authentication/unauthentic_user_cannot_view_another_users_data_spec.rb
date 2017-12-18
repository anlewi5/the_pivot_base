require 'rails_helper'

RSpec.feature "Unauthenticated users security" do
  # let(:user) { create(:registered_user) }
  # let(:order) { create(:order, user: user)}
  # let(:unicorn_onesie_1) { create(:item) }

  before(:each) do
    user = create(:user)
    role = create(:registered_user)
    user.roles << role
    @order = create(:order, user: user)
    @unicorn_onesie_1 = create(:item)
  end

  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      visit dashboard_index_path

      expect(current_path).to eq(login_path)

      expect {
        visit order_path(@order)
      }.to raise_exception(ActionController::RoutingError)
    end

    it "I should be redirected to login/create account when I try to check out" do
      visit item_path(@unicorn_onesie_1)

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to_not have_content("Checkout")

      visit new_order_path

      expect(current_path).to eq(login_path)
    end

    it "I cannot view the administrator screens or use administrator functionality" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end
  end
end
