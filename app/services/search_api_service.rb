class SearchApiService
  
  def initialize(attrs = {})
    @type = attrs[:type]
    @search_word = attrs[:q]
  end

  def search
    if type == 'items' && search_word
      Item.where("title like ? OR description like ?", "%#{search_word}%", "%#{search_word}%")
    end
  end

  private
    attr_reader :type, :search_word

end
