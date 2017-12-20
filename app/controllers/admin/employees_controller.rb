class Admin::EmployeesController < ApplicationController

  def index
    @stores = User.find(current_user.id).stores
  end

  def update
    UserRole.admin_update(user_role_params)

    redirect_to admin_employees_path
  end

  private

    def user_role_params
      not_found unless User.find(current_user.id).stores.find(params[:store_id])
      params.permit(:id, :store_id, :fire)
    end

end
