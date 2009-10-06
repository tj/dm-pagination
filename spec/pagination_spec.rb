
# User.all.page(5, :per_page => 2)

require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Pagination do
  before :each do
    DataMapper.auto_migrate!
    1.upto 20 do |n|
      instance_variable_set :"@item_#{n}", Item.create
    end 
  end
  
  def items from, to
    (from..to).map do |n|
      instance_variable_get :"@item_#{n}"
    end
  end
  
  describe "#page" do
    it "should default page to 1, :per_page to 6, and :order to :id.desc" do
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
  
  describe "#total" do
    it "should be assigned when paging" do
      Item.all.page.length.should == 6
      Item.all.page.total.should == 20
    end
  end
end
