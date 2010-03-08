
module DataMapper
  module Pagination

    @defaults = {
      :per_page      => 6,
      :size          => 7,
      :pager_class   => 'pager',
      :previous_text => 'Previous',
      :next_text     => 'Next',
      :first_text    => 'First',
      :last_text     => 'Last',
      :more_text     => '...',
      :page_param    => :page
    }

    ##
    # Default pagination values.
    #
    # === Options
    #
    #   :per_page       Records per page; defaults to 6
    #   :size           Number of intermediate page number links to be shown; Defaults to 7
    #   :pager_class    Class for the div that contains the pagination links, defaults to 'pager'
    #   :previous_text  Text for the 'previous' link, defaults to 'Previous'
    #   :next_text      Text for the 'next' link, defaults to 'Next'
    #   :first_text     Text for the 'first' link, defaults to 'First'
    #   :last_text      Text for the 'last' link, defaults to 'Last'
    #   :more_text      Text for the 'more' indicator, defaults to '...'
    #
    # === Examples
    #
    #   DataMapper::Pagination.defaults[:size] = 5
    #

    def self.defaults
      @defaults
    end

  end
end
