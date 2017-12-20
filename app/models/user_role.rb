class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :store, optional: true

  def self.admin_update(user_id, store_id, fire = nil)
    user_role = find_by(user_id: user_id, store_id: store_id)
    return user_role.destroy if fire

    promote_user(user_role)
  end

  private

    def self.promote_user(user_role)
      role = Role.find_by(name: "Store Admin")

      user_role.update(role: role)
    end
end
