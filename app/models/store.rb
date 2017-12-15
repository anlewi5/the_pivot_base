class Store < ApplicationRecord

  has_many :items

  enum status: ["pending", "active", "suspended"]

end
