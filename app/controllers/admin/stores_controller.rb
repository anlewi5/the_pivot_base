class Admin::StoresController < ApplicationController
  before_action :require_admin

  def index
    @stores = Store.all
  end

  def update
    store = Store.find(params[:id])
    store.update_status(params[:status])

    redirect_to admin_stores_path
  end
end
