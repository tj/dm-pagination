
module DataMapper
  module Pagination
    
    ##
    # DataMapper::Pager instance.
    
    attr_accessor :pager
    
    ##
    # Page collection by the _page_ number and _options_ provided.
    #
    # Since pagers will commonly be used with query strings, we 
    # coerce all numeric strings such as '12' to their integer value 12.
    # This is the case for _page_, :per_page, :page, etc.
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
    
    def page page = nil, options = {}
      options, page = page, nil if page.is_a? Hash
      page ||= pager_option :page, options
      options.delete :page
      page = 1 unless (page = page.to_i) && page > 1
      per_page = pager_option(:per_page, options).to_i
      query = options.dup
      collection = new_collection scoped_query(options = {
        :limit => per_page,
        :offset => (page - 1) * per_page,
        :order => [:id.desc]
      }.merge(query))
      query.delete :order
      options.merge! :total => count(query), :page => page
      collection.pager = DataMapper::Pager.new options
      collection
    end
    
    private
    
    ##
    # Return value for _key_ from indifferent hash _options_.
    # 
    #  * Checks for sym key
    #  * Checks for string key
    #  * Checks DataMapper::Pagination.defaults for the sym key
    #  * Deletes both keys to prevent them from being part of the query
    #
    
    def pager_option key, options = {}
      a = options.delete key.to_sym
      b = options.delete key.to_s
      a || b || Pagination.defaults[key.to_sym]
    end
  end
end
