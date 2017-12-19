class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    if params[:status] == "ordered" || params[:status] == "paid" || params[:status] == "cancelled" || params[:status] == "completed"
      @orders = Order.filter_by_status(params[:status], current_user)
    else
      @orders = Order.all_for_admin(current_user)
    end
    flash[:notice] = "You're logged in as #{current_user.highest_role}."
  end
end
