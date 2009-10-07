
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
    # === Arguments
    #
    #   base_path   The base path for the generated links, e.g. /projects/popular
    #
    # === Options
    #
    #   :size   Number of intermediate page number links to be shown; Defaults to 7
    #
    
    def to_html base_path, options = {}
      @base_path = base_path
      @size = options.delete(:size) || 7
      return if total_pages <= 0
      @offset = current_page < @size ? 0 : 
          total - current_page < @size ?
            total - @size : 
              current_page - @size / 2 - 1
      '<div class="pager">' + first_link + previous_link + '<ul>' + 
      more(:before) +
      intermediate_links[@offset, @size].join("\n") + 
      more(:after) +
      '</ul>' + next_link + last_link + '</div>'
    end
    
    def link_to page, contents = nil
      contents ||= page
      %(<a href="#{build_uri(page)}" class="link-#{contents.to_s.downcase.tr(' ', '-')}">#{contents}</a>)
    end
    
    def more position
      return '' if position == :before && @offset == 0
      %(<li class="more">...</li>\n)
    end
    
    def intermediate_links
      raise ArgumentError, 'invalid :size; must be an odd number' if @size && @size % 2 == 0
      (1..@size || total_pages).map { |n|
        (n == current_page ? 
          '<li class="active">%s</li>' : 
            '<li>%s</li>') % link_to(n)
      }
    end
    
    def previous_link
      previous_page ? link_to(previous_page, 'Previous') : ''
    end
    
    def next_link
      next_page ? link_to(next_page, 'Next') : ''
    end
    
    def last_link
      next_page ? link_to(total, 'Last') : ''
    end
    
    def first_link
      previous_page ? link_to(1, 'First') : ''
    end
    
    def build_uri(page)
      if @base_path =~ /page=\d+/
        @base_path.gsub(/page=\d+/, "page=#{page}")
      elsif @base_path =~ /\?/
        @base_path += "&page=#{page}"
      else
        @base_path += "?page=#{page}"
      end
    end
    
  end
end