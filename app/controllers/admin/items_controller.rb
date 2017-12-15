class Admin::ItemsController < ApplicationController
  before_action :require_admin
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @stores = Store.all
    @categories = Category.all
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to admin_items_path
    else
      redirect_to new_admin_item_path
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_items_path
    else
      redirect_to edit_admin_item_path(item)
    end
  end

  def edit
    @item = Item.find(params[:id])
    @stores = Store.all
    @categories = Category.all
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :store_id, :category_id, :image)
  end

  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
