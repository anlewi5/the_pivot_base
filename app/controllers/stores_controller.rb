class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.create_with_user(store_params, current_user)
    redirect_to dashboard_index_path
  end

  private

    def store_params
      params.require(:store).permit(:name)
    end
end