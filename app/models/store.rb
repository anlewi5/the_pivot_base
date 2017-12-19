class Store < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :items
  has_many :orders

  before_validation :generate_url

  enum status: ["pending", "active", "suspended"]

  def self.create_with_user(store_info, user)
    store = create(store_info)
    store.associate_user(user)
    store
  end

  def associate_user(user)
    role = Role.find_by(name: "Registered User")
    user_roles.create(user: user, role: role)
  end

  def active_items
    items.active
  end

  def update_status(status, initial_req = nil)
    if initial_req
      promote_creator_to_admin
    end

    update(status: status)
  end

  private

    def generate_url
      self.url = name.parameterize
    end

    def promote_creator_to_admin
      store_admin_role = Role.find_by(name: "Store Admin")
      user_roles.first.update(role: store_admin_role)
    end
end
