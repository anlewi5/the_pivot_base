
class Platform::OrdersController < ApplicationController
  before_action :require_admin

  def index
    @orders = Order.all
  end
end