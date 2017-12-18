class PermissionsService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    if user.platform_admin?
      platform_admin_permissions
    elsif user.store_admin?
      store_admin_permissions
    elsif user.store_manager?
      store_manager_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private
    attr_reader :user, :controller, :action

    def platform_admin_permissions
      return true if controller == 'users' && action.in?(%w(edit update))
      return true if controller == 'admin/stores' && action.in?(%w(index update))
      store_admin_permissions
    end

    def store_admin_permissions
      return true if controller == 'admin/items' && action.in?(%w(new create))
      store_manager_permissions
    end

    def store_manager_permissions
      return true if controller == 'admin/dashboard' && action == 'index'
      return true if controller == 'admin/items' && action.in?(%w(index show edit update))
      return true if controller == 'orders' && action.in?(%w(update new))
      registered_user_permissions
    end

    def registered_user_permissions
      return true if controller == 'user/stores' && action.in?(%w(index))
      return true if controller == 'stores' && action.in?(%w(index show new create))
      return true if controller == 'orders' && action.in?(%w(index show))
      guest_user_permissions
    end

    def guest_user_permissions
      return true if controller == 'main' && action == 'index'
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
      return true if controller == 'dashboard' && action == 'index'
      return true if controller == 'stores' && action.in?(%w(index show))
      return true if controller == 'categories' && action.in?(%w(index show))
      return true if controller == 'items' && action.in?(%w(index show))
      return true if controller == 'carts' && action.in?(%w(index create destroy update))
      return true if controller == 'orders' && action.in?(%w(new))
      return true if controller == 'users' && action.in?(%w(new create))
    end
end