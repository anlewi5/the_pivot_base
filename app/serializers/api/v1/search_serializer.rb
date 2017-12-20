class Api::V1::SearchSerializer < ActiveModel::Serializer
  attributes :type, :search_word

  
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

end
