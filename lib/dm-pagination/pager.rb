
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
    # Previous page or nil when no previous page is available.
    
    attr_reader :previous_page
    
    ##
    # Next page or nil when no more pages are available.
    
    attr_reader :next_page
    
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
      @next_page = current_page + 1 unless current_page >= @total_pages
      @previous_page = current_page - 1 unless current_page <= 1
    end
    
    ##
    # Render the pager with the given _options_.
    
    def to_html options = {}
      previous_link + next_link
    end
    
    def link_to uri, contents = nil
      %(<a href="#{uri}">#{contents || uri}</a>)
    end
    
    def previous_link
      previous_page ?
        link_to(previous_page, 'Previous') :
          ''
    end
    
    def next_link
      next_page ?
        link_to(next_page, 'Next') :
          ''
    end
    
  end
end