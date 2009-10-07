module DataMapper
  module Pagination

    @@defaults = {
      :per_page            => 6,
      :size                => 7,
      :pager_class         => 'pager',
      :previous_text       => 'Previous',
      :next_text           => 'Next',
      :first_text          => 'First',
      :last_text           => 'Last',
      :previous_link_class => 'link-previous',
      :next_link_class     => 'link-next',
      :first_link_class    => 'link-first',
      :last_link_class     => 'link-last',
      :page_link_class     => 'link-',
      :more_class          => 'more'
    }

    ##
    # Default pagination values.
    #
    # === Options
    #
    #   :per_page              Records per page; defaults to 6
    #   :size                  Number of intermediate page number links to be shown; Defaults to 7
    #   :pager_class           Class for the div that contains the pagination links, defaults to 'pager'
    #   :previous_text         Text for the 'previous' link, defaults to 'Previous'
    #   :next_text             Text for the 'next' link, defaults to 'Next'
    #   :first_text            Text for the 'first' link, defaults to 'First'
    #   :last_text             Text for the 'last' link, defaults to 'Last'
    #   :previous_link_class   CSS class for the 'previous' link
    #   :next_link_class       CSS class for the 'next' link
    #   :first_link_class      CSS class for the 'first' link
    #   :last_link_class       CSS class for the 'last' link
    #   :page_link_class       CSS class for intermediate page links (will be suffixed with the actual page number)
    #   :more_class            CSS class for the more placeholder
    #
    # Class related defaults may be set to nil to prevent their usage.
    #
    
    def self.defaults
      @@defaults
    end

  end
end