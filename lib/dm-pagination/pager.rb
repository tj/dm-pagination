
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
    # Render the pager with the given _uri_ and _options_.
    # 
    # === Examples
    #
    #   User.page(2).pager.to_html('/users')
    #   User.page(2).pager.to_html('/users', :size => 3)
    #
    # === Options
    #
    #   :size   Number of intermediate page number links to be shown; Defaults to 7
    #
    
    def to_html uri, options = {}
      return if total_pages <= 0
      @uri = uri
      @size = options.fetch :size, Pagination.defaults[:size]
      raise ArgumentError, 'invalid :size; must be an odd number' if @size % 2 == 0
      @size /= 2
      "<div class=\"#{Pagination.defaults[:pager_class]}\">" + first_link + previous_link + '<ul>' + 
      more(:before) + intermediate_links.join("\n") + more(:after) +
      '</ul>' + next_link + last_link + '</div>'
    end
    
    def link_to page, contents = nil
      %(<a href="#{uri_for(page)}" class="#{contents.to_s.downcase.tr(' ', '-')}">#{contents || page}</a>)
    end
    
    def more position
      return '' if position == :before && (current_page <= 1 || first <= 1)
      return '' if position == :after && (current_page >= total_pages || last >= total_pages)
      %(<li class="more">...</li>\n)
    end
    
    def intermediate_links
      (first..last).map do |page|
        classes = current_page == page ? ['active'] : []
        classes << "page-#{page}"
        classes << 'first' if first == page
        classes << 'last' if last == page
        '<li class="%s">%s</li>' % [classes.join(' '), link_to(page)]
      end
    end
    
    def previous_link
      previous_page ? link_to(previous_page, Pagination.defaults[:previous_text]) : ''
    end
    
    def next_link
      next_page ? link_to(next_page, Pagination.defaults[:next_text]) : ''
    end
    
    def last_link
      next_page ? link_to(total_pages, Pagination.defaults[:last_text]) : ''
    end
    
    def first_link
      previous_page ? link_to(1, Pagination.defaults[:first_text]) : ''
    end

    def first
      first = [current_page - @size, 1].max
      if (current_page - total_pages).abs < @size
        first = [first - (@size - (current_page - total_pages).abs), 1].max
      end
      first
    end

    def last
      last = [current_page + @size, total_pages].min
      if @size >= current_page
        last = [last + (@size - current_page) + 1, total_pages].min
      end
      last
    end

    def uri_for page
      @uri['page'] ?
        @uri.gsub(/page=\d+/, "page=#{page}") :
          @uri['?'] ?
            @uri += "&page=#{page}" :
              @uri += "?page=#{page}"
    end
    
  end
end