class User::StoresController < ApplicationController
  def index
    @stores = current_user.stores
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    store = Store.find(params[:format])
    if store.update(store_params)
      flash[:success] = "Store name successfully updated!"
      redirect_to user_stores_path
    else
      flash[:success] = "Oops! Something went wrong."
      render :edit
    end
  end

  private

    def store_params
      params.require(:store).permit(:name)
    end
end