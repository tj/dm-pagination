#--
# Copyright (c) 2009 TJ Holowaychuk <tj@vision-media.ca>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require 'dm-core'

module DataMapper

  module Pagination

    @@defaults = {
      :records_per_page    => 6,
      :page_window         => 7,
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
    # Default values used by the paginator
    #
    # === Options
    #
    #   :records_per_page      Records per page; defaults to 6
    #   :page_window           Number of intermediate page number links to be shown; Defaults to 7
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
    # Set +nil+ for the CSS classes when you don't want classes to be applied to the links.
    #
    def self.defaults
      @@defaults
    end

  end

end

require 'dm-aggregates'
require 'dm-pagination/version'
require 'dm-pagination/pagination'
require 'dm-pagination/pager'
require 'dm-pagination/view_helper'

DataMapper::Model.send :include, DataMapper::Pagination
DataMapper::Collection.send :include, DataMapper::Pagination
DataMapper::Query.send :include, DataMapper::Pagination

ActionView::Base.send :include, DataMapper::Pagination::ViewHelper::Rails if defined?(ActionView::Base)
