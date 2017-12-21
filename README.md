# The Pivot - Base Project

[![CircleCI](https://circleci.com/gh/anlewi5/the_pivot_base.svg?style=shield)](https://circleci.com/gh/anlewi5/the_pivot_base)

The following Rails app is used as the base project for [The Pivot](http://backend.turing.io/module3/projects/the_pivot).

## Setup

Built using Ruby 2.4.1 and Rails 5.1.3

Install required gems:
`$ bundle install`  

For image hosting, this application uses Paperclip, which depends on ImageMagick. To install ImageMagick on Mac OS X, you'll want to run the following with [Homebrew](http://www.brew.sh): `$ brew install imagemagick `

Load the database dump:
`$ rake import_dump:load`

After the import you should see a return value of 1011 when running `Item.count` in the console.

All users have a password of `password` if you want to login and explore.

## Testing

This application is tested using [RSpec](https://github.com/rspec/rspec-rails). Run `$ rspec` from the command line to run the test suite.

It may be necessary to prepare the test database if additional migrations have been created. Run `$ rake db:test:prepare` to update the test database with the latest schema. 
