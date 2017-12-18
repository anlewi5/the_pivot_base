FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "Gob_#{n}" }
    sequence(:last_name) { |n| "Bluth_#{n}" }
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
  end

  factory :admin, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
  end
end
