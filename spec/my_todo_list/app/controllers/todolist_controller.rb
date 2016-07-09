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
    todolist = Todo.new todo_params
    todolist.save
    redirect_to "/todos"
  end

  def update
    todolist = Todo.find(params["id"])
    todolist.update(todo_params)
    redirect_to "/todos"
  end

  def destroy
    @todolist = Todo.find(params["id"])
    @todolist.destroy
    redirect_to "/todos"
  end

  private

  def todo_params
    { title: params["title"], todo: params["todo"], status: params["status"] }
  end
end
