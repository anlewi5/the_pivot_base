class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart, :set_categories

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end


  def current_admin?
    platform_admin_role = Role.find_by(name: "Platform Admin")

    (current_user && current_user.admin?) ||
      (current_user && current_user.roles.include?(platform_admin_role))
  end


  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end

  private
    def require_admin
      not_found unless current_admin?
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
