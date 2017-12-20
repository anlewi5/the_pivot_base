class Admin::EmployeesController < ApplicationController

  def index
    @stores = User.find(current_user.id).stores
  end

  def update
    UserRole.admin_update(params[:id], params[:store_id], params[:fire])

    redirect_to admin_employees_path
  end

end
