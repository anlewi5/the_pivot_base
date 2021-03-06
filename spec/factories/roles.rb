FactoryBot.define do
  factory :platform_admin, class: Role do
    name "Platform Admin"
  end

  factory :store_admin, class: Role do
    name "Store Admin"
  end

  factory :store_manager, class: Role do
    name "Store Manager"
  end

  factory :registered_user, class: Role do
    name "Registered User"
  end
end