
require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Pager do
  before(:each) { mock_items }
  
  describe "#to_html" do
    describe "when pages are available" do
      it "should render a ul.pager list" do
        Item.page.pager.to_html.should include('<ul class="pager">')
      end
    end
    
    describe "when on the first page" do
      it "should not render the 'Previous' page link" do
        markup = Item.page.pager.to_html
        markup.should_not include('Previous')
      end
      
      it "should render some intermediate page links" do
        markup = Item.page.pager.to_html
        markup.should include('>1<')
        markup.should include('>2<')
        markup.should include('>3<')
      end
    end
    
    describe "when on the last page" do
      it "should not render the 'Next' page link" do
        markup = Item.page(4).pager.to_html
        markup.should_not include('Next')
      end
    end
    
    describe "when on an intermediate page" do
      it "should render the 'Previous' page link" do
        markup = Item.page(2).pager.to_html
        markup.should include('Previous')
      end
      
      it "should render the 'Next' page link" do
        markup = Item.page(2).pager.to_html 
        markup.should include('Next')
      end
    end
    
  end
end