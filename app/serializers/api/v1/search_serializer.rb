class Api::V1::SearchSerializer < ActiveModel::Serializer
  extend ItemSerializer
  extend StoreSerializer
  extend UserSerializer
  extend CategorySerializer
end
