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

module DataMapper
  module Is
    module Paginated
      
      ##
      # Plugin API.
      
      def is_paginated options = {}
        extend ClassMethods
      end
      
      module ClassMethods
        
        ##
        # Page collection by _current_page_ number and _options_ provided.
        #
        # === Options
        #
        #   :per_page   Results per page; defaults to 6
        #   :order      Defaults to [:id.desc]
        #
        # === Examples
        #    
        #   code
        #
        
        def page current_page = 1, options = {}
          new_collection scoped_query({
            :limit => per_page = (options.delete(:per_page) || 6),
            :offset => (current_page - 1) * per_page,
            :order => [:id.desc]
          }.merge(options))
        end
      end
    end
  end
end

DataMapper::Model.append_extensions DataMapper::Is::Paginated