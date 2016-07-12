require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)
ROOT_FOLDER = __dir__ + "/my_todo_list"
require 'paitin_hana'
require 'rspec'
require 'rack/test'
require "my_todo_list/config/application.rb"

ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.include FactoryGirl::Syntax::Methods
  conf.before(:suite) do
    FactoryGirl.find_definitions
  end
end

RSpec.shared_context type: :feature do
  require "capybara/rspec"
  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/my_todo_list/config.ru"
    ).first
    Capybara.app = app
  end
end
