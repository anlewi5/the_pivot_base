class User < ApplicationRecord
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :stores, through: :user_roles
  has_many :orders

  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: ["default", "admin"]

  def full_name
    first_name + " " + last_name
  end

  def highest_role
    return "a #{roles.last.name}" if !roles.empty?
    return "an Administrator" if roles.empty?
  end

  def date_joined
    created_at.strftime('%b. %d, %Y')
  end

  def current_admin?
    return true if platform_admin?
    return true if store_admin?
    return true if store_manager?
  end

  def platform_admin?
    roles.exists?(name: 'Platform Admin')
  end

  def store_admin?
    roles.exists?(name: 'Store Admin')
  end

  def store_manager?
    roles.exists?(name: 'Store Manager')
  end

  def registered_user?
    roles.exists?(name: 'Registered User')
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end
end
