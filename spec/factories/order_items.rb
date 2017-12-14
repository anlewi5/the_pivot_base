FactoryBot.define do
  factory :order_item do
    item
    order
    quantity 1
    unit_price { item.price }
  end
end
