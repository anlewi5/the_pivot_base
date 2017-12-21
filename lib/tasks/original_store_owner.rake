desc "Associate the original admin with the original store"
task original_store_admin_association: :environment do
  original_admin = User.find_by(first_name: "Mary", email: "mary@example.com")
  store_admin = Role.find_by(name: "Store Admin")
  store = Store.find_by(name: "Little Shop of Funsies")
  UserRole.find_or_create_by(user: original_admin, role: store_admin, store: store)
end
