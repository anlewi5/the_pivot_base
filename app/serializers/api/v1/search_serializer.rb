class Api::V1::SearchSerializer < ActiveModel::Serializer
  extend ItemSerializer
  extend StoreSerializer
  extend OrderSerializer
  extend CategorySerializer

end
