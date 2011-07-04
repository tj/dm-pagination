
module DataMapper::Pagination::Helpers::Rails

  ##
  # Renders the pagination links for the given _collection_.
  #
  # === Options
  #
  #   :params  Hash of params that is passed to url_for
  #   :size    Number of intermediate page number links to be shown; Defaults to 7
  
  def paginate collection, options = {}
    uri = url_for params.merge(options[:params] || {})
    collection.pager.to_html(uri, options).to_s.html_safe
  end

end
