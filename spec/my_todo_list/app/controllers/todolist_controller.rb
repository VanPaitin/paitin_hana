class TodolistController < PaitinHana::BaseController
  def index
    @todolists = Todo.all
  end

  def show
    @todolist = Todo.find(params["id"])
  end

  def new
  end

  def edit
    @todolist = Todo.find(params["id"])
  end

  def create
    todolist = Todo.new
    todolist.title = params["title"]
    todolist.todo = params["todo"]
    todolist.status = params["status"]
    todolist.created_at = Time.now.strftime("%I:%M.%S %p on %a, %b %d, %Y")
    todolist.updated_at = todolist.created_at
    todolist.save
    redirect_to "/todos"
  end

  def update
    todolist = Todo.find(params["id"])
    todolist.title = params["title"]
    todolist.todo = params["todo"]
    todolist.status = params["status"]
    todolist.updated_at = Time.now.strftime("%I:%M.%S %p on %a, %b %d, %Y")
    todolist.save
    redirect_to "/todos"
  end

  def destroy
    @todolist = Todo.find(params["id"])
    @todolist.destroy
    redirect_to "/todos"
  end
end
