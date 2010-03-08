
require File.dirname(__FILE__) + '/../spec_helper'

describe DataMapper::Pager do
  before(:each) { mock_items }

  describe "#to_html" do
    describe "when pages are available" do
      it "should render a ul.pager wrapper" do
        begin
          Item.page.pager.to_html('/').should match(/ul class="([^"]+)?"/)
        rescue =>e
          puts e.class, e.message, e.backtrace.join("\n")
        end
      end

      it "should render a ul containing intermediate items" do
        Item.page.pager.to_html('/').should match(/<ul class="[^"]+?"><li/)
      end

      it "should add the 'active' class to the current page link <li>" do
        Item.page.pager.to_html('/').should include('li class="page-1 active"><a href="/?page=1"')
        Item.page(2).pager.to_html('/').should include('li class="page-2 active"><a href="/?page=2"')
        Item.page(3).pager.to_html('/').should include('li class="page-3 active"><a href="/?page=3"')
      end

      it "should add li.last.jump" do
        Item.page.pager.to_html('/').should include('<li class="last jump">')
      end

      it "should add li.first.jump" do
        Item.page(2).pager.to_html('/').should include('<li class="first jump"')
      end

      it "should add li.next.jump" do
        Item.page.pager.to_html('/').should include('<li class="next jump">')
      end

      it "should add li.previous.jump" do
        Item.page(2).pager.to_html('/').should include('<li class="previous jump">')
      end

      it "should allow setting the paging parameter name" do
          Item.page(2, :page_param => :hot_stuff).pager.to_html("/items").should include("href=\"/items?hot_stuff=2\"")
      end
    end

    describe "when one page is available" do
      it "should render nothing" do
        Item.all(:id.lt => 2).page.pager.to_html('/').should be_nil
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
        markup.should_not include('>4<')
        markup.should include(%(<li class="more">...</li>\n<li class="next jump"))
      end

      it "should not render ... before" do
        markup = Item.page.pager.to_html('/', :size => 3)
        markup.should_not include('<a href="/?page=3" class="previous jump">Previous</a><li class="more">...</li>')
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

    [:first, :previous, :next, :last].each do |pos|
      describe "with the #{pos.inspect} option set" do
        it "should change the default contents for the '#{pos}' link" do
          markup = Item.page(2, :per_page => 2).pager.to_html('/', :"#{pos}_text" => 'FOO')
          markup.should include('>FOO<')
        end
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
        markup.should include(%(<li class="previous jump"><a href="/?page=3">Previous</a></li>\n<li class="more">...<))
        markup.should_not include('>1<')
        markup.should include('>2<')
        markup.should include('>3<')
        markup.should include('>4<')
        markup.should_not include('>5<')
      end

      it "should not render ... after" do
        markup = Item.page(4).pager.to_html('/', :size => 3)
        markup.should_not include(%(<li class="more">...</li>\n<a href="/?page=6" class="next jump"))
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
        markup.should include(%(<li class="previous jump"><a href="/?page=4">Previous</a></li>\n<li class="more">...</li>))
        markup.should_not include('>3<')
        markup.should include('>4<')
        markup.should include('>5<')
        markup.should include('>6<')
        markup.should_not include('>7<')
        markup.should include(%(<li class="more">...</li>\n<li class="next jump"))
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

    describe "when on the second page" do
      it "should render 1 through 3 when :size is 3 followed by ..." do
        markup = Item.page(2, :per_page => 2).pager.to_html('/', :size => 3)
        markup.should_not include('<ul><li class="more">...<')
        markup.should include('>1<')
        markup.should include('>2<')
        markup.should include('>3<')
        markup.should_not include('>4<')
        markup.should include(%(<li class="more">...</li>\n<li class="next jump"))
      end
    end

    describe "when on the second last page" do
      it "should render 8 through 10 when :size is 3 with preceding ..." do
        markup = Item.page(9, :per_page => 2).pager.to_html('/', :size => 3)
        markup.should include(%(<li class="previous jump"><a href="/?page=8">Previous</a></li>\n<li class="more">...<))
        markup.should_not include('>7<')
        markup.should include('>8<')
        markup.should include('>9<')
        markup.should include('>10<')
        markup.should_not include('>11<')
        markup.should_not include(%(<li class="more">...</li>\n<li class="next jump"))
      end
    end

    describe "when passing a uri without a query string" do
      it "should append a query string to each uri" do
        markup = Item.page.pager.to_html 'items'
        markup.should include('items?page=1')
      end
    end

    describe "when passing a uri with a query string" do
      describe "containing page=N" do
        it "should alter the page value" do
          markup = Item.page.pager.to_html 'items?page=2'
          markup.should include('items?page=1')
        end
      end

      describe "not containing page=N" do
        it "should append a pair" do
          markup = Item.page.pager.to_html 'items?foo=bar'
          markup.should include('items?foo=bar&page=1')
        end
      end

      describe "when containing other keys with 'page'" do
        it "should append a pair" do
          markup = Item.page.pager.to_html 'items?per_page=5'
          markup.should include('items?per_page=5&page=1')
          markup = Item.page.pager.to_html 'items?page=4&per_page=3'
          markup.should include('items?page=1&per_page=3')
        end
      end
    end

  end
end
