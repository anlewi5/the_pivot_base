class CategorySerializer < ActiveModel::Serializer
  attributes :title, :number_of_items

  def number_of_items
    object.items.count
  end
end
