require 'rails_helper'

describe "Search Items API" do
  describe "get /api/v1/search?type=items&q='keyword'" do
    it "calls #search_by(params) on search_api_service and returns a collection as json" do
      search_api_service = double()

      allow(SearchApiService).to receive(:new) { search_api_service }
      expect(search_api_service).to receive(:search).once

      get "/api/v1/search?type=items&q=books"

      expect(response).to be_success
    end
  end
end
