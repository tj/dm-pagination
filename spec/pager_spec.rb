
require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Pager do
  before(:each) { mock_items }
  
  describe "#to_html" do
    describe "when on the first page" do
      it "should not render the 'Previous' page link" do
        markup = Item.page.pager.to_html
        markup.should_not include('Previous')
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