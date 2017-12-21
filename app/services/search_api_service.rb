class SearchApiService

  def initialize(attrs = {})
    @type = attrs[:type]
    @search_word = attrs[:q]
  end

  def search
    
  end

  private
    attr_reader :type, :keyword

end
