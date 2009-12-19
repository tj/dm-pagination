
1.0.1 / 2009-12-19
==================

  * Actually Fixes PostgresError (typo)

1.0.0 / 2009-12-07
==================

  * Fixes PostgresError when ordering with aggregation function count(*) [#23]

0.0.8 / 2009-10-27
==================

  * Fixed param replacement boundary issue [#22]

0.0.7 / 2009-10-10
==================

  * Renamed to dm-pager (available on gemcutter)

0.0.6 / 2009-10-08
==================

  * Added #option and specs for overriding defaults with #to_html [#13]
  * Added "jump" class to first,last,prev,next <li>'s [#17]
  * Added ability to configure "..." text when more pages are available

0.0.5 / 2009-10-07
==================

  * #to_f -> #quo
  * Fixed pager from being rendered when only one page is available

0.0.4 / 2009-10-07
==================

  * Added DataMapper::Pagination#pager_option 
  * Fixed :per_page; now may be 'per_page' as well
  * Fixed :per_page; now allows for numeric strings

0.0.3 / 2009-10-07
==================

  * Fixed issue caused by indifferent params hash having both :page and 'page' keys

0.0.2 / 2009-10-07
==================

  * Allowing #page :page param, as alternative to the current_page arg (User.page(params) vs User.page(params[:page]))
  * Fixed issue when page is a string (from query string); Coerce strings to ints
  * Fixed issue when page is nil; now considered first page

0.0.1 / 2009-10-07
===================

  * Initial release