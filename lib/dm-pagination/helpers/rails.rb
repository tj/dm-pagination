
module DataMapper::Pagination::Helper::Rails
  def paginate collection, options = {}
    uri = @template.url_for @template.params.merge(options[:params] || {})
    collection.pager.to_html uri, options
  end
end