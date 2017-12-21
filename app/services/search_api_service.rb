class SearchApiService

  def initialize(attrs = {})
    @type = attrs[:type].downcase
    @search_word = attrs[:q]
  end

  def search
    if search_word
      search_word_search
    else
      all_search
    end
  end

  private
    attr_reader :type, :search_word

    def all_search
      case type
      when 'items', 'item'
        Item.all
      when 'stores', 'store'
        Store.all
      when 'users', 'user'
        User.all
      when 'category', 'categories'
        Category.all
      end
    end

    def search_word_search
      insensitive_search_word = search_word.downcase
      case type
      when 'items', 'item'
        Item.where("title ilike ? OR description ilike ?", "%#{insensitive_search_word}%", "%#{insensitive_search_word}%")
      when 'stores', 'store'
        Store.where("name ilike ?", "%#{insensitive_search_word}%")
      when 'users', 'user'
        User.where("first_name ilike ? OR last_name ilike ?", "%#{insensitive_search_word}%", "%#{insensitive_search_word}%")
      when 'category', 'categories'
        Category.where("title ilike ?", "%#{insensitive_search_word}%")
      end
    end
end
