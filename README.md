# PaitinHana

[![Code Climate](https://codeclimate.com/github/andela-mpitan/paitin_hana/badges/gpa.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hana)
[![Test Coverage](https://codeclimate.com/github/andela-mpitan/paitin_hana/badges/coverage.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hana/coverage)
[![Build Status](https://travis-ci.org/andela-mpitan/paitin_hana.svg?branch=master)](https://travis-ci.org/andela-mpitan/paitin_hana)

PaitinHana is an MVC ruby mini-framework, that is modeled after rails. PaitinHana takes majority of its inspiration from rails but it is not by any means as complex or robust as rails.

It is however a good fit for simple applications. It makes available some of the great features of rails.

## Version

The current version is 0.1.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paitin_hana'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paitin_hana

## Features
  * ORM
  * Supports Testing.
  * Custom model properties types e.g int, str, time and date.
  * Render html views that support Javascript DOM manipulations
  
## Usage

When creating a new PaitinHana app, a few things need to be setup and a few rules adhered to. PaitinHana basically follows the same folder structure as a typical rails app with all of the models, views and controller code packed inside of an app folder, configuration based code placed inside a config folder and the main database file in a db folder.

View a sample app built using PaitinHana framework [Here](https://github.com/andela-mpitan/my_todo_list)

### Routing
Routing with PaitinHana deals with directing requests to the appropriate controllers. A sample route file is:

```ruby
TodoApplication.routes.draw do
  get "/todo", to: "todo#index"
  get "/todo/new", to: "todo#new"
  post "/todo", to: "todo#create"
  get "/todo/:id", to: "todo#show"
  get "/todo/:id/edit", to: "todo#edit"
  patch "/todo/:id", to: "todo#update"
  put "/todo/:id", to: "todo#update"
  delete "/todo/:id", to: "todo#destroy"
end
```
PaitinHana can support GET, DELETE, PATCH, POST, PUT requests.


### Models
All models to be used with the PaitinHana framework are to inherit from the BaseModel class provided by PaitinHana, in order to access the rich ORM functionalities provided. The BaseModel class acts as an interface between the model class and its database representation. A sample model file is provided below:

```ruby
class Todo < PaitinHana::ORM::BaseModel
  property :id, type: :integer, primary_key: true
  property :title, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :status, type: :text, nullable: false
  property :created_at, type: :text, nullable: false
  create_table
end
```

The `property` method is provided to declare table columns, and their properties. The first argument to `property` is the column name, while subsequent hash arguments are used to provide information about properties.

## Limitations

  This version of the gem does not include...
  * support model relationships.
  * implement callbacks.
  * support migration generation.
  * generate a schema.
  * handle floating point precision numbers.
  * support generators

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-mpitan/paitin_hana. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
Below is the simple guideline for contributing.

* [Fork it](https://github.com/andela-mpitan/paitin_hana/fork)
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin my-new-feature)
* Create a new Pull Request



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

