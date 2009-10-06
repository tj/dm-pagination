
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
      @total = options.delete :total
      @per_page = options.delete :limit
      @current_page = options.delete :current_page
      @total_pages = (total.to_f / per_page).ceil
      @next_page = current_page + 1 unless current_page >= total_pages
      @previous_page = current_page - 1 unless current_page <= 1
    end
    
    ##
    # Render the pager with the given _options_.
    #
    # === Options
    #
    #   :size   Number of intermediate page number links to be shown; Defaults to 6
    #
    
    def to_html options = {}
      return if total_pages <= 0
      # offset = active < size ? 0 : 
      #     array.length - active < size ?
      #       array.length - size : 
      #         active - size / 2 - 1
      # array[offset, size]
      previous_link + '<ul class="pager">' + intermediate_links(options.delete(:size)) + '</ul>' + next_link
    end
    
    def link_to uri, contents = nil
      %(<a href="#{uri}">#{contents || uri}</a>)
    end
    
    def intermediate_links size = 6
      raise ArgumentError, 'invalid :size; must be an odd number' if size && size % 2 == 0
      (1..size || total_pages).map { |n|
        (n == current_page ? 
          '<li class="active">%s</li>' : 
            '<li>%s</li>') % link_to(n)
      }.join("\n")
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