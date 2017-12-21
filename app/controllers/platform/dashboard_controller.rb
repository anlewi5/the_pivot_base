class Platform::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @orders = Order.all
    flash[:notice] = "You're logged in as #{current_user.highest_role}."
  end
end
