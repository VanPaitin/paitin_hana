require "spec_helper"

RSpec.describe MyTodoList, type: :feature, js: true do
  before(:all) do
    Todo.destroy_all
  end

  after(:each) do
    Todo.destroy_all
  end

  scenario "root path is the index page" do
    visit "/"
    expect(page).to have_title "index"
  end

  feature "todo items display" do
    scenario "when there are no todo items" do
      visit "/todos"
      expect(page).to have_selector(
        "h3",
        text: "You have not created any Todos"
      )
      expect(page).to have_no_css("table")
    end

    context "when todo items have been created" do
      it "should list the todo items in a tabular form" do
        create_list(:todo, 3)

        visit "/todos"
        expect(page).to have_css("table")
        within "table" do
          expect(page).to have_text "Title"
          expect(page).to have_content "Content"
          expect(page).to have_content "Status"
        end
      end

      it "should list items created on the index page" do
        todolist = create(:todo)

        visit "/todos"
        expect(page).to have_content todolist.todo
        expect(page).to have_content todolist.title
      end
    end
  end

  feature "todo item creation" do
    scenario "creating a todo item" do
      expect do
        visit "/todo/new"
        fill_in "title", with: "A test todo"
        fill_in "todo", with: "This is a test todo"
        choose "Done"
        click_button "Submit"
      end.to change(Todo, :count).by 1
    end
  end

  feature "showing a todo item" do
    scenario "visiting a todo item's show page" do
      todolist = Todo.create(attributes_for(:todo))

      visit "/todos"
      click_link todolist.title
      expect(current_path).to eql "/todo/#{todolist.id}"
      expect(page).to have_selector("div.panel-heading", text: todolist.title)
      expect(page).to have_selector("div.panel-body", text: todolist.todo)
      within "div.panel-footer" do
        expect(page).to have_content todolist.created_at
        expect(page).to have_content todolist.updated_at
      end
    end
  end

  feature "todo item update and deletion" do
    before(:each) do
      @todolist = Todo.create(attributes_for :todo)
    end

    scenario "updating a todo item" do
      old_title = @todolist.title

      visit "/todo/#{@todolist.id}/edit"
      fill_in "title", with: "TIA"
      fill_in "todo", with: "This is Andela"
      choose "Done"
      expect { click_button "submit" }.to change(Todo, :count).by 0
      reloaded_todo = Todo.find @todolist.id
      expect(@todolist.title).to_not eql "TIA"
      expect(reloaded_todo.title).to eql "TIA"
    end

    scenario "deleting a todo item" do
      visit "/todos"
      click_button "delete-item"
      click_button "Yes"
      expect(page).to have_no_content @todolist.title
      expect(page).to have_content "You have not created any Todos"
    end
  end

  feature "response to invalid routes" do
    scenario "visiting an invalid route" do
      visit "/invalid_routes"
      expect(page).to have_content "Route not found"
    end
  end
end
