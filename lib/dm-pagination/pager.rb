
module DataMapper
  class Pager
    
    ##
    # Total number of un-limited records.
    
    attr_reader :total 
    
    ##
    # Records per page.
    
    attr_reader :per_page 
    
    ##
    # Current page number.
    
    attr_reader :current_page
    
    ##
    # Total number of pages.
    
    attr_reader :total_pages
    
    ##
    # Initialize with _options_.
    
    def initialize options = {}
      @total = options.delete(:total) || 0
      @per_page = options.delete :limit
      @current_page = options.delete :current_page
      @total_pages = (total.to_f / per_page.to_f).ceil
    end
    
    ##
    # Render the pager with the given _options_.
    # Additional options are passed to the formatter.
    # 
    # === Options
    #
    #   :formatter   Defaults to DataMapper::Pager::Formatter
    #
    
    def to_html options = {}
      (options.delete(:formatter) || Formatter).new(self, options).to_html
    end
    
  end
end