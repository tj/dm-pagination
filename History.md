
0.0.2 / 2009-10-07
==================

  * Allowing #page :page param, as alternative to the current_page arg (User.page(params) vs User.page(params[:page]))
  * Fixed issue when page is a string (from query string); Coerce strings to ints
  * Fixed issue when page is nil; now considered first page

0.0.1 / 2009-10-07
===================

  * Initial release