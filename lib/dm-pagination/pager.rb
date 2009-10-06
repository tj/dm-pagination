
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
    # Initialize with _options_.
    
    def initialize options = {}
      @total = options.delete :total
      @per_page = options.delete :limit
      @current_page = options.delete :current_page
    end
    
    ##
    # Render the pager with the given _formatter_
    # which defaults to DataMapper::Pager::Formatter
    
    def to_html
      Formatter.new(self).to_html
    end
    
    #--
    # Default formatter
    #++
    
    class Formatter
      
      ##
      # Pager instance.
      
      attr_reader :pager
      
      ##
      # Initialize with _pager_.
      
      def initialize pager
        @pager = pager
      end
    end
    
  end
end