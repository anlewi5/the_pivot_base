class Admin::EmployeesController < ApplicationController

  def index
    @stores = User.find(current_user.id).stores
  end

  def update
    UserRole.admin_update(user_role_params)
    if current_user.platform_admin?
      redirect_to edit_platform_user_path(params[:id])
    else
      redirect_to admin_employees_path
    end
  end

  private

    def user_role_params
      if !current_user.platform_admin?
        not_found unless User.find(current_user.id).stores.find(params[:store_id])
      end
      params.permit(:id, :store_id, :fire)
    end

end
