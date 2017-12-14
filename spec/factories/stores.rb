FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "Store Name #{n}"}
    status "pending"
    sequence(:url) { |n| "store-name-#{n}"}
  end
end
