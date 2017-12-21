class Api::V1::ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price
end
