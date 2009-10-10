
$:.unshift 'lib'
require 'rubygems'
require 'dm-core'
require 'dm-pager'

DataMapper.setup :default, 'sqlite3::memory:'

class Item
  include DataMapper::Resource
  property :id,   Serial
end

def mock_items
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