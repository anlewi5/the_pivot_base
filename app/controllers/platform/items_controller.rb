class Platform::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
    @stores = Store.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to platform_items_path
    else
      render :edit
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :store_id, :category_id, :image)
    end
end