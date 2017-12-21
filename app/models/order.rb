class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :store

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def update_total_price
    update(total_price: order_items.sum(:total_price))
  end

  def date
    created_at.strftime('%b. %d, %Y')
  end

  def self.count_by_status
    group(:status).count
  end

  def self.filter_by_status(status, user)
    if user.platform_admin?
      where(status: status)
    else
      where(store: user.stores).where(status: status)
    end
  end

  def self.count_of_completed_orders
    where(status: :completed).count
  end

  def self.shop_total_gross
		where(status: :completed).joins(:items).sum(:price)
  end

  def self.all_for_admin(user)
    if user.platform_admin?
      Order.all
    else
      where(store: user.stores)
    end
  end

end
