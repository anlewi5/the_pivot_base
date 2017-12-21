class AddStoreToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :store, foreign_key: true
  end
end
