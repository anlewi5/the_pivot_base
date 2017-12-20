class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :store, optional: true

  def self.admin_update(params)
    user_role = find_by(user_id: params[:id], store_id: params[:store_id])
    return user_role.destroy if params[:fire]

    promote_user(user_role)
  end

  private

    def self.promote_user(user_role)
      role = Role.find_by(name: "Store Admin")

      user_role.update(role: role)
    end
end
