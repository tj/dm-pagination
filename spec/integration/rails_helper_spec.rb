
require File.dirname(__FILE__) + '/../spec_helper'

describe DataMapper::Pagination::Helpers::Rails do
  include DataMapper::Pagination::Helpers::Rails

  describe '#paginate' do
    before do
      @collection = stub 'Collection', :pager => stub('Pager')
      @template = stub 'Template', :path => 'path', :params => { :foo => :bar }, :url_for => '/projects/popular?page=3'
    end

    it "should invoke the pager's #to_html method'" do
      @collection.pager.should_receive(:to_html).once.with('/projects/popular?page=3', {})
      paginate(@collection)
    end
  end
end
