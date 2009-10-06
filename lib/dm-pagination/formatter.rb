
module DataMapper
  class Pager
    class Formatter
      
      ##
      # Pager instance.
      
      attr_reader :pager
      
      ##
      # Initialize with _pager_ and _options_.
      
      def initialize pager, options = {}
        @pager = pager
      end
      
      def to_html
        ''
      end
      
    end
  end
end