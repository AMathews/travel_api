# README

This is a simple generated Rails 6.1 app and assumes a working ruby installation with bundler 2 installed.


* Ruby version `3.0.2` specified in `.ruby-version` for version managers

* How to run the test suite: `bundle exec rspec`

* It is run using the standard `rails s` and it defaults to serving at `localhost:3000`

* Implemented api route examples:
  * `*/countries` 
    * returns all country data
  * `*/countries/basic_info/:code`
    * returns the basic info requested in part 1 of the challenge
    * For Brazil you would hit `*/countries/basic_info/bra`
  * `*/countries/find_capitals/:min_lat/:max_lat/:min_long/:max_long` 
    * returns the list of capitals requested in part 2 of the challenge
    * For a box containing western coastal europe you would hit `*/countries/find_capitals/40/60/-40/0` 
