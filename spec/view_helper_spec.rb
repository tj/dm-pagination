require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Pagination::ViewHelper::Rails do

  include DataMapper::Pagination::ViewHelper::Rails

  describe '#paginate' do

    before do
      @collection = stub('Collection', { :pager => stub('Pager') })
      @template = stub('Template', { :path => 'path', :params => {} })
    end

    it "should invoke the pager's to_html method'" do
      @collection.pager.should_receive(:to_html).once.with(@template.path, {})

      paginate(@collection)
    end

  end

end
