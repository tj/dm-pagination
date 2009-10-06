
module DataMapper
  module Pagination
    
    ##
    # Number of unlimited results which is derived
    # from the #page query without :limit and :offset.
    
    attr_accessor :total
    
    ##
    # Page collection by the _current_ page number and _options_ provided.
    #
    # === Options
    #
    #   :per_page   Results per page; defaults to 6
    #   :order      Defaults to [:id.desc]
    #
    # === Examples
    #    
    #   User.all.
    #
    
    def page current = 1, options = {}
      options, current = current, 1 if current.is_a? Hash
      collection = new_collection scoped_query({
        :limit => per_page = (options.delete(:per_page) || 6),
        :offset => (current - 1) * per_page,
        :order => [:id.desc]
      }.merge(options))
      collection.total = count options
      collection
    end
  end
end
