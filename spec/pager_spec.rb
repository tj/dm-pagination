
require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Pager do
  before(:each) { mock_items }
  
  describe "#to_html" do
    describe "when pages are available" do
      it "should render a div.pager wrapper" do
        Item.page.pager.to_html('/').should include('<div class="pager">')
      end
      
      it "should render a ul containing intermediate items" do
        Item.page.pager.to_html('/').should include('<ul><li')
      end
      
      it "should add the 'active' class to the current page link <li>" do
        Item.page.pager.to_html('/').should include('li class="active"><a href="/?page=1"')
        Item.page(2).pager.to_html('/').should include('li class="active"><a href="/?page=2"')
        Item.page(3).pager.to_html('/').should include('li class="active"><a href="/?page=3"')
      end
      
      it "should add link-FOO classes to the anchor tag" do
        Item.page.pager.to_html('/').should include('class="link-last">Last')
      end
    end
    
    describe "when no pages are available" do
      it "should render nothing" do
        Item.all(:id.lt => 1).page.pager.to_html('/').should be_nil
      end
    end
    
    describe "when on the first page" do
      it "should not render the 'Previous' page link" do
        markup = Item.page.pager.to_html('/')
        markup.should_not include('Previous')
      end
      
      it "should render some intermediate page links with ... after" do
        markup = Item.page.pager.to_html('/', :size => 3)
        markup.should include('>1<')
        markup.should include('>2<')
        markup.should include('>3<')
        markup.should include(%(class="more">...</li>\n</ul>))
      end
      
      it "should not render ... before" do
        markup = Item.page.pager.to_html('/', :size => 3)
        markup.should_not include('class="pager">...<')
      end
      
      it "should not render the 'First' page link" do
        markup = Item.page.pager.to_html('/')
        markup.should_not include('First')
      end
      
      it "should render the 'Last' page link" do
        markup = Item.page.pager.to_html('/')
        markup.should include('Last')
      end
    end
    
    describe "with the :size option set" do
      it "should raise an error when given an even number" do
        lambda { Item.page.pager.to_html('/', :size => 2) }.should raise_error(ArgumentError, /must be an odd number/)
      end
      
      it "should render only the specified number of intermediate page links" do
        markup = Item.page.pager.to_html('/', :size => 3)
        markup.should include('>1<')
        markup.should include('>2<')
        markup.should include('>3<')
        markup.should_not include('>4<')
      end
    end
    
    describe "when on the last page" do
      it "should not render the 'Next' page link" do
        markup = Item.page(4).pager.to_html('/')
        markup.should_not include('Next')
      end
      
      it "should not render the 'Last' page link" do
        markup = Item.page(4).pager.to_html('/')
        markup.should_not include('Last')
      end
      
      it "should render the 'First' page link" do
        markup = Item.page(4).pager.to_html('/')
        markup.should include('First')
      end
      
      it "should render some intermediate page links with ... before" do
        markup = Item.page(4).pager.to_html('/', :size => 3)
        markup.should include('class="pager"><li class="more">...<')
        markup.should include('>2<')
        markup.should include('>3<')
        markup.should include('>4<')
      end
      
      it "should not render ... after" do
        markup = Item.page(4).pager.to_html('/', :size => 3)
        markup.should_not include('<li class="more">...</li></ul>')
      end
    end
    
    describe "when on an intermediate page" do
      it "should render the 'Previous' page link" do
        markup = Item.page(2).pager.to_html('/')
        markup.should include('Previous')
      end
      
      it "should render the 'Next' page link" do
        markup = Item.page(2).pager.to_html('/') 
        markup.should include('Next')
      end
      
      it "should render some intermediate page links with ... before and after" do
        markup = Item.page(5, :per_page => 2).pager.to_html('/', :size => 3)
        markup.should include('<ul class="pager"><li class="more">...<')
        markup.should include('>4<')
        markup.should include('>5<')
        markup.should include('>6<')
        markup.should include('<li class="more">...</li></ul>')
      end
      
      it "should render the 'Last' page link" do
        markup = Item.page(2).pager.to_html('/')
        markup.should include('Last')
      end
      
      it "should render the 'First' page link" do
        markup = Item.page(2).pager.to_html('/')
        markup.should include('First')
      end
    end
    
  end
end