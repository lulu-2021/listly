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

## Configuration

Firstly in your rails config/application.rb - you need to set the two config variables
for the listly gem. The :local_list_store is for the next release. It doesn't do anything just yet.
The :local_list_constants, is a symbol of a simple module that needs to be loaded in the rails
load process i.e. putting it in the lib folder will suffice. The module (see below) just needs
to contain a list of constants and their respective values that relate to where the list data
is stored. The default is to store this data in the i18n internatialisation files in
config/locales. Anywhere will do since they all will be loaded!


```ruby

module YourRailsApp
  class Application < Rails::Application
    ...
    config.listly.listly_store_location = :local_list_store
    config.listly.listly_constants_module = :local_list_constants
    ...
  end
end

```

Here is an example of the module and some sample constants that will be turned into lists.

```ruby

module LocalListConstants

  STATE_TYPES = :state_type_hash
  SEX_TYPES = :sex_type_hash

end

```

The in the "config/locales/views/en.yml" (this can be in any of the locale files) you can
put the respective data relating to the above constant values.

```ruby

  states_hash: [
    {code: 'act', name: 'ACT', desc: 'Australian Capital Teritory'},
    {code: 'nsw', name: 'NSW', desc: 'New South Wales'},
    {code: 'nt', name: 'NT', desc: 'Northern Teritory'},
    {code: 'qld', name: 'QLD', desc: 'Queensland'},
  ]
  sex_types_hash: [
    {code: 'male', name: 'Male'},
    {code: 'female', name: 'Female'},
    {code: 'notset', name: 'Not Set'}
  ]

```

Listly will create a module from each constant with its respective data. It will create
an internal class that holds instance properties and attr_reader access methods for each.
i.e. "states_hash: code" will be the code attribute on the list etc..

## Usage

To therefore use this in a view template in rails or a form - you simply need to include
the module with the list into the view template. I frequently use mustache view wrappers
which would look like this:

```ruby

require "mustache_extras"

module Wrapper
  module Person

    class New < ::Stache::Mustache::View
      include PageHeader
      include Mustache::FormBuilder
      include Wrapper::Person::Form
      include SexTypeList   # <------ This is the included list module!

```

Then in the actual form... this is how you can use the list - i.e. the method
"all_sex_types" was derived from the "SexType" module name and the "sex_type_code"
and "sex_type_name" methods will populate the form with the relevant "code" and
"name" data - that was pulled from your i18n locale file!


```ruby

sex_field: f.collection_select(:sex, all_sex_types, :sex_type_code, :sex_type_name, {
  label: t('patients.sex'),
  config: {
    prompt: t('form.please_select'),
  }
}),

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/listly/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
