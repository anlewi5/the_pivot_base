class Api::V1::SearchController < Api::ApplicationController
  
  def index
    render json: search_api_service.search, to: SearchSerializer
  end

  private
    def search_params
      params.permit(:type, :q)
    end

    def search_api_service
      SearchApiService.new(search_params)
    end
end
