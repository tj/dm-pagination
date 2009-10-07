module DataMapper

  module Pagination

    module ViewHelper

      module Rails

        def paginate(collection, options = {})
          collection.pager.to_html(
            @template.url_for(@template.params.merge(options[:params] || {})),
            options
          )
        end

      end

      module Merb

        #TODO: add view helper for Merb!

      end

    end

  end

end
