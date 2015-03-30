# Listly

There are lots of occasions in Rails apps where you need simple lists, such as a list of States in a Country etc.
Listly is for when you want to store data in hash format in external yml type files such as storing them in the
rails locales files that can be retrieved from I18n.

## Travis CI
[![Build Status](https://travis-ci.org/netflakes/listly.svg?branch=master)](https://travis-ci.org/netflakes/listly)

## Coveralls
[![Coverage Status](https://coveralls.io/repos/netflakes/listly/badge.svg?branch=master)](https://coveralls.io/r/netflakes/listly?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'listly'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install listly

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/listly/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
