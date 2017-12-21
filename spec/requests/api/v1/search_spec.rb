require 'rails_helper'
# GET "/api/v1/search?type=items&q=diapers&api_key=YOUR_REAL_KEY"
#
# The above query should return all items with a title or description containing the word "diapers"
# At some point we might want to allow searching other tables and but let's stick to only items for now.

# Return data should be JSON and like this:
# {
#   "type": "items",
#   "q": "diapers",
#   "results": [
#     {
#       "id": 1,
#       "title": "Nature's Diapers",
#       "description": "No chemicals or dyes. Also, they don't really work.",
#       "price": "$30.00"
#     },
#     {
#       "id": 103,
#       "title": "Dopo Tesigns Shoulder Bag",
#       "description": "Versitile bag great for commuting. Even makes as an excellent diaper bag. #dadcore #momcore",
#       "price": "$125.00"
#     }
#   ]
# }

describe "Search Items API" do
  describe "get /api/v1/search?type=items&q='keyword'" do
    it "calls #search_by(params) on search_api_service and returns a collection as json" do
      # params = {'type': 'items', 'q': 'books'}
      search_api_service = double()

      # expect(search_api_service).to receive(:search).with(params).once
      expect(search_api_service).to receive(:search).once

      get "/api/v1/search?type=items&q=books"

      expect(response).to be_success
    end
  end
end
