
module DataMapper::Pagination::Helper::Rails
  def paginate(collection, options = {})
    collection.pager.to_html(
      @template.url_for(@template.params.merge(options[:params] || {})),
      options
    )
  end
end