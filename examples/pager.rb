
$:.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'dm-core'
require 'dm-pager'

class Item
  include DataMapper::Resource
  property :id,   Serial
end

DataMapper.setup :default, 'sqlite3::memory:'
DataMapper.auto_migrate!
(1..10).each { |n| Item.create }

def show example
  puts example
  expr = eval example
  if String === expr
    puts expr + "\n\n"
  else
    puts "# => #{eval(example).inspect}\n\n"
  end
end

puts "Items: #{Item.all.count}\n\n"
show 'Item.page'
show 'Item.page(2)'
show 'Item.page(1, :per_page => 4)'
show 'Item.page(1, :per_page => 4).pager'
show 'Item.page(1, :per_page => 4).pager.to_html "/items" '
show 'Item.page(1, :per_page => 4).pager.to_html "/items?foo=bar" '
show 'Item.page(2, :per_page => 4).pager.to_html "/items?page=2" '
show 'Item.page(1, :per_page => 2).pager.to_html("/items", :size => 3)'
show 'Item.page(2, :per_page => 2).pager.to_html("/items", :size => 3)'
show 'Item.page(3, :per_page => 2).pager.to_html("/items", :size => 3)'
show 'Item.page(4, :per_page => 2).pager.to_html("/items", :size => 3)'
