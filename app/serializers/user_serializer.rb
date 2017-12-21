class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name
  has_many :stores
end
