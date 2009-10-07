
require File.dirname(__FILE__) + '/../spec_helper'

describe DataMapper::Pagination do
  before(:each) { mock_items }
  
  describe "#page" do
    describe "given the page" do
      it "return the appropriately sized collection" do
        Item.page(1, :order => [:id.asc]).should == items(1, 6)
        Item.page(2, :order => [:id.asc]).should == items(7, 12)
        Item.page(3, :order => [:id.asc]).should == items(13, 18)
      end
    
      describe "number" do
        it "should default to the first page" do
          Item.page.pager.current_page.should == 1
        end
      end
      
      describe "nil" do
        it "should default to the first page" do
          Item.page(nil).pager.current_page.should == 1
        end
      end
      
      describe "number below 1" do
        it "should default to the first page" do
          Item.page(0).pager.current_page.should == 1
          Item.page(-1).pager.current_page.should == 1
        end
      end
      
      describe "string" do
        it "should be coerced to ints" do
          Item.page('5').pager.current_page.should == 5
          Item.page('5.0').pager.current_page.should == 5
          Item.page('-1').pager.current_page.should == 1
        end
        
        describe "which is not numeric" do
          it "should default to the first page" do
            Item.page('wahoo').pager.current_page.should == 1
          end
        end
      end
      
      describe "of an arbitrary object" do
        it "should raise an error unless responding to #to_i" do
          lambda { Item.page(true) }.should raise_error
        end
      end
    end

    describe "options hash" do
      it "should be accepted as first param" do
        Item.page(:page => 2, :order => [:id.asc]).pager.current_page.should == 2
      end
      
      it "should be accepted as second param" do
        Item.page(3, :page => 2, :order => [:id.asc]).pager.current_page.should == 3
      end
    end
    
    describe "option" do
      describe ":per_page" do
        it "should default to 6" do
          Item.page.length.should == 6
        end
        
        it "should be allow an alternate value" do
          Item.page(1, :per_page => 3, :order => [:id.asc]).should == items(1, 3)
          Item.page(2, :per_page => 3, :order => [:id.asc]).should == items(4, 6)
          Item.page(3, :per_page => 3, :order => [:id.asc]).should == items(7, 9)
        end
        
        it "should allow numeric strings" do
          Item.page(1, :per_page => '3', :order => [:id.asc]).should == items(1, 3)
          Item.page(2, :per_page => '3', :order => [:id.asc]).should == items(4, 6)
          Item.page(3, :per_page => '3', :order => [:id.asc]).should == items(7, 9)
          Item.page(3, :per_page => '3', :order => [:id.asc]).pager.per_page.should == 3
        end
        
        it "should delete keys when an indifferent hash is passed" do
          Item.page(1, 'per_page' => '3', :order => [:id.asc]).should == items(1, 3)
          Item.page(2, 'per_page' => '3', :order => [:id.asc]).should == items(4, 6)
          Item.page(3, 'per_page' => '3', :order => [:id.asc]).should == items(7, 9)
          Item.page(3, 'per_page' => '3', :order => [:id.asc]).pager.per_page.should == 3
        end
      end
      
      describe ":order" do
        it "should default to [:id.desc]" do
          Item.page.should == items(15, 20).reverse
        end
      end
      
      describe ":page" do
        it "should raise an error unless responding to #to_i" do
          lambda { Item.page(:page => true) }.should raise_error
          lambda { Item.page('page' => true) }.should raise_error
        end
        
         it "should delete keys when an indifferent hash is passed" do
           Item.page(:page => '2', 'page' => '2', :order => [:id.asc]).should == items(7, 12)
           Item.page(:page => '2', 'page' => '2', :order => [:id.asc]).pager.current_page.should == 2
        end
      end
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
