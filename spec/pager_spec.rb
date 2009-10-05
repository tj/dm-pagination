
# User.all.page(5, :per_page => 2)

require File.dirname(__FILE__) + '/spec_helper'

describe DataMapper::Is::Paginated do
  before :each do
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
      Item.all.page.should == items(1, 6).reverse
    end
  end
end