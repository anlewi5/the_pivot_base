class StoresController < ApplicationController

  def show
    @store = Store.find_by(url: params[:store])
  end

end
