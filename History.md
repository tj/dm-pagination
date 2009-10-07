
=== 0.0.4 / 2009-10-07

  * Added DataMapper::Pagination#pager_option 
  * Fixed :per_page; now may be 'per_page' as well
  * Fixed :per_page; now allows for numeric strings

=== 0.0.3 / 2009-10-07

  * Fixed issue caused by indifferent params hash having both :page and 'page' keys

0.0.2 / 2009-10-07
==================

  * Allowing #page :page param, as alternative to the current_page arg (User.page(params) vs User.page(params[:page]))
  * Fixed issue when page is a string (from query string); Coerce strings to ints
  * Fixed issue when page is nil; now considered first page

0.0.1 / 2009-10-07
===================

  * Initial release