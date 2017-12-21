class OrderSerializer < ActiveModel::Serializer
  attributes :status, :store

  def store
    object.store.name
  end

end
