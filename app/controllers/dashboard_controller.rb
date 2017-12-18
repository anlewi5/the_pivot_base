class DashboardController < ApplicationController

  def index
    if current_user.nil?
      redirect_to login_path
    elsif current_user.current_admin?
      redirect_to admin_dashboard_index_path
    elsif current_user.registered_user?
      @user = User.find(current_user.id)
    end
  end

end
