
module DataMapper
  module Pagination
    
    ##
    # DataMapper::Pager instance.
    
    attr_accessor :pager
    
    ##
    # Page collection by the _page_ number and _options_ provided.
    #
    # === Options
    #
    #   :page       Current page number
    #   :per_page   Results per page; defaults to 6
    #   :order      Defaults to [:id.desc]
    #
    # === Examples
    #    
    #   User.all.page
    #   User.all.page(2)
    #   User.all.page(2, :per_page => 5)
    #   User.all.page(:page => 2, :per_page => 5)
    #
    
    def page page = 1, options = {}
      options, page = page, nil if page.is_a? Hash
      page ||= options.delete(:page); options.delete('page')
      page = 1 unless (page = page.to_i) && page > 1
      query = options.dup
      collection = new_collection scoped_query(options = {
        :limit => per_page = (query.delete(:per_page) || Pagination.defaults[:per_page]),
        :offset => (page - 1) * per_page,
        :order => [:id.desc]
      }.merge(query))
      options.merge! :total => count(query), :page => page
      collection.pager = DataMapper::Pager.new options
      collection
    end
  end
end
