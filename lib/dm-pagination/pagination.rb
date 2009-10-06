
module DataMapper
  module Pagination
    
    ##
    # DataMapper::Pager instance.
    
    attr_accessor :pager
    
    ##
    # Page collection by the _current_page_ number and _options_ provided.
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
    
    def page current_page = 1, options = {}
      options, current_page = current_page, 1 if current_page.is_a? Hash
      query = options.dup
      collection = new_collection scoped_query(options = {
        :limit => per_page = (query.delete(:per_page) || 6),
        :offset => (current_page - 1) * per_page,
        :order => [:id.desc]
      }.merge(query))
      options.merge! :total => count(query), :current_page => current_page
      collection.pager = DataMapper::Pager.new options
      collection
    end
  end
end
