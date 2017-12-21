require 'rails_helper'

RSpec.feature "As a logged in user" do
  context "when I visit an inactive store path" do
    let(:user) { create(:user) }
    let(:role) { create(:registered_user) }

    context "because the store is pending" do
      it "renders a 404 error" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        user.roles << role

        store = create(:store, name: "Nocturne", status: "pending")

        expect {
          visit store_path(store.url)
        }.to raise_error(ActionController::RoutingError)
      end
    end

    context "because the store is suspended" do
      it "renders a 404 error" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        user.roles << role

        store = create(:store, name: "Nocturne", status: "pending")

        expect {
          visit store_path(store.url)
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
