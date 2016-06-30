require_relative "config/application.rb"
use Rack::MethodOverride
TodoList = MyTodoList::Application.new
require_relative "config/routes.rb"

run TodoList
