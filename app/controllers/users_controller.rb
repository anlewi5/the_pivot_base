class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
    session[:user_id] = user.id
    redirect_to dashboard_index_path
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect
    else
      render file: "/public/404"
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end

  def redirect
    if current_user.platform_admin?
      redirect_to platform_dashboard_index_path
    elsif current_user.registered_user?
      redirect_to dashboard_index_path
    else
      redirect_to admin_dashboard_index_path
    end
  end
end
