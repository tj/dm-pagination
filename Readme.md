
# DataMapper::Pager

  Better paging solution for DataMapper for DM >= 0.10.1
  
# About

Not to be confused with the dm-pagination gem (a similar gem lacking in functionality) dm-pager
is a new, fresh, and feature rich pagination implementation for DataMapper. Due to Github's gem builder
being destroyed, we were forced to rename our gem to 'dm-pager' which is now available on [Gemcutter.org](http://gemcutter.org).

# Installation

Install [Gemcutter](http://gemcutter.org) and execute:
    $ sudo gem install dm-pager
  
# Examples

Page 1 for all items, defaulting to 6 per page:
    Item.page
    // => [1, 2, 3, 4, 5, 6]
    
Page 2 for all items, 6 per page, with only 3 items remaining
    Item.page 2
    // => [7, 8, 9]
    
Page 3, 2 per page:
    Item.page 3, :per_page => 2
    // => [5, 6]
    
Accessing the pager instance:
    Item.page(1, :per_page => 4).pager
    // => #<DataMapper::Pager:0x1610f20 @per_page=4, @next_page=2, @total_pages=3, @total=10, @current_page=1>
    
Converting to HTML:
    Item.page(2).pager.to_html('/items')
    // => "<div class=\"pager\">..."
    
Alter the number of intermediate numbered links displayed, defaults to 7
    Item.page(2).pager.to_html('/items', :size => 3)
    // => "<div class=\"pager\">..."
    
# Output

Output is displayed in a format similar to below, although 
with CSS you may hide anything you wish to remove. There is
no need to provide an API for this.

    Item.page(2).pager.to_html('/items', :size => 3)
    // => First Previous 1 [2] 3 ... Next Last
    
    Item.page.pager.to_html '/items'
    // => [1] 2 3 4 5 6 7 ... Next Last

    Item.page(5).pager.to_html('/items', :size => 5)
    // => First Previous ... 3 4 [5] 6 7 ... Next Last
    
# Markup

Sample query:
    Item.page(2, :per_page => 2).pager.to_html("/items", :size => 3)

Sample markup:

    <div class="pager">
      <a href="/items?page=1" class="first">First</a>
      <a href="/items?page=1" class="previous">Previous</a>
      <ul>
        <li class="page-1 first"><a href="/items?page=1" class="">1</a></li>
        <li class="active page-2"><a href="/items?page=2" class="">2</a></li>
        <li class="page-3 last"><a href="/items?page=3" class="">3</a></li>
        <li class="more">...</li>
      </ul>
      <a href="/items?page=3" class="next">Next</a>
      <a href="/items?page=5" class="last">Last</a>
    </div>
    
## Running Specs

Autospec:
    $ autospec
  
Rake:
    $ rake spec
    $ rake spec:verbose
    $ rake spec:select SPEC=spec/unit/pager_spec.rb
    
RSpec:
    $ spec --color spec
    
## Authors

 * TJ Holowaychuk <tj@vision-media.ca>
 * Marco Otte-Witte <http://simplabs.com>
    
## License

(The MIT License)

Copyright (c) 2009 TJ Holowaychuk <tj@vision-media.ca>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, an d/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
