require "./config/application.rb"
ROOT_FOLDER = __dir__
use Rack::MethodOverride
TodoList =  MyTodoList::Application.new
require "./config/routes.rb"

run TodoList
