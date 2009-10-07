
require File.dirname(__FILE__) + '/../spec_helper'

describe DataMapper::Pagination do
  before(:each) { mock_items }
  
  describe "#page" do
    it "should default page to 1" do
      Item.page.pager.current_page.should == 1
    end
    
    it "should treat a page < 1 as the first page" do
      Item.page(0).pager.current_page.should == 1
      Item.page(-1).pager.current_page.should == 1
    end
    
    it "should treat nil as the first page" do
      Item.page(nil).pager.current_page.should == 1
    end
    
    it "should default :per_page to 6" do
      Item.page.length.should == 6
    end
    
    it "should default :order to [:id.desc]" do
      Item.page.should == items(15, 20).reverse
    end

    it "should allow a hash of options as the first parameter" do
      Item.page(:order => [:id.asc]).should == items(1, 6)
    end

    it "should allow a hash of options as the second parameter" do
      Item.page(1, :order => [:id.asc]).should == items(1, 6)
    end

    it "should allow a page number to be passed as the first parameter" do
      Item.page(1, :order => [:id.asc]).should == items(1, 6)
      Item.page(2, :order => [:id.asc]).should == items(7, 12)
      Item.page(3, :order => [:id.asc]).should == items(13, 18)
    end

    it "should allow :per_page to be overriden" do
      Item.page(1, :per_page => 3, :order => [:id.asc]).should == items(1, 3)
      Item.page(2, :per_page => 3, :order => [:id.asc]).should == items(4, 6)
      Item.page(3, :per_page => 3, :order => [:id.asc]).should == items(7, 9)
    end

    it "should allow chaining of queries" do
      Item.all(:id.lt => 4).page.should be_a(DataMapper::Collection)
    end
  end
  
  describe "#pager" do
    describe "#total" do
      it "should be assigned when paging" do
        Item.all.page.length.should == 6
        Item.all.page.pager.total.should == 20
      end
    end
    
    describe "#per_page" do
      it "should be assigned when paging" do
        Item.all.page.pager.per_page.should == 6
      end
    end
    
    describe "#current_page" do
      it "should be assigned when paging" do
        Item.all.page.pager.current_page.should == 1
        Item.all.page(3).pager.current_page.should == 3
      end
    end
    
    describe "#total_pages" do
      it "should be assigned when paging" do
        Item.all.page.pager.total_pages.should == 4
        Item.all.page(:per_page => 3).pager.total_pages.should == 7
        Item.all.page(:per_page => 2).pager.total_pages.should == 10
      end
    end
  end
end
