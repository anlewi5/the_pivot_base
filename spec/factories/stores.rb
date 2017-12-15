FactoryBot.define do
  factory :store do
    sequence(:name) { |n| "Store Name #{n}"}
    status 0
    sequence(:url) { |n| "store-name-#{n}"}
  end
end
