class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price

  def price
    "$#{object.price}"
  end
end
