class StoresController < ApplicationController

  before_action :active_store?, only: [:show]

  def show
    @store = Store.find_by(url: params[:store])
  end

  def new
    @store = Store.new
  end

  def create
    store = Store.create_with_user(store_params, current_user)

    flash[:notice] = "You have successfully requested the creation of a new store, #{store.name}!"

    redirect_to dashboard_index_path
  end

  private

    def store_params
      params.require(:store).permit(:name)
    end

    def active_store?
      store = Store.find_by(url: params[:store])
      not_found unless store && store.active?
    end

end
