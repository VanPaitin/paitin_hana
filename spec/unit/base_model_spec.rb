require "spec_helper"
RSpec.describe PaitinHana::ORM::BaseModel do
  describe ".all" do
    context "when the database is not empty" do
      before(:all) do
        Todo.destroy_all
        create_list(:todo, 4)
      end

      after(:all) do
        Todo.destroy_all
      end

      it "returns the correct number of items in a database table" do
        expect(Todo.all.count).to eq 4
      end

      it "returns objects as elements of an array" do
        expect(Todo.all.first).to be_a Todo
        expect(Todo.all.last).to be_a Todo
      end
    end

    context "when the todo table is empty" do
      it "returns an empty array" do
        expect(Todo.all.empty?).to eq true
      end
    end
  end

  describe ".count" do
    after(:all) do
      Todo.destroy_all
    end
    it "returns the correct number of records in a database" do
      create_list(:todo, 2)
      expect(Todo.count).to eq 2
    end
  end

  describe ".find" do
    after(:all) do
      Todo.destroy_all
    end

    it "returns object when an id that has a record is entered" do
      object = create(:todo)
      expect(Todo.find(Todo.last.id).title).to eq object.title
    end

    it "returns nil when an id with no record is entered" do
      invalid_id = Todo.last.id + 1
      expect(Todo.find(invalid_id)).to eq nil
    end
  end

  describe ".last" do
    after(:all) do
      Todo.destroy_all
    end

    context "when database table is not empty" do
      it "returns the last record of the table" do
        create(:todo)
        last_todo = create(:todo)
        expect(Todo.last.todo).to eq last_todo.todo
      end
    end

    context "when the database table is empty" do
      it "returns nil if the table is empty" do
        Todo.destroy_all
        expect(Todo.last).to eq nil
      end
    end
  end

  describe ".first" do
    after(:all) do
      Todo.destroy_all
    end

    context "when the database table is empty" do
      it "returns nil if the table is empty" do
        expect(Todo.first).to eq nil
      end
    end

    context "when database table is not empty" do
      it "returns the last record of the table" do
        first_todo = create(:todo)
        create_list(:todo, 2)
        expect(Todo.first.title).to eq first_todo.title
        expect(Todo.first.todo).to eq first_todo.todo
      end
    end
  end

  describe ".destroy" do
    it "deletes the record from the table" do
      object = create(:todo)
      Todo.destroy(object.id)
      expect(Todo.find(object.id)).to eq nil
    end
  end

  describe ".destroy_all" do
    it "deletes every record in the database" do
      create_list(:todo, 3)
      Todo.destroy_all
      expect(Todo.count).to eq 0
    end
  end

  describe "#destroy" do
    it "deletes the object from the database" do
      object = Todo.create(attributes_for(:todo))
      expect do
        object.destroy
      end.to change(Todo, :count).by(-1)
    end
  end

  describe "#update" do
    before(:all) do
      @object = Todo.create(attributes_for(:todo))
    end
    after(:all) do
      Todo.destroy_all
    end

    it "doesn't create a new record in the database" do
      expect do
        @object.update(title: "Changed")
      end.to change(Todo, :count).by 0
    end

    it "updates the object" do
      @object.update(todo: "do this for me")
      expect(Todo.find(@object.id).todo).to eq "do this for me"
    end
  end

  describe "#save" do
    after(:all) do
      Todo.destroy_all
    end

    context "when the object has no id " do
      it "creates a new record in the database" do
        new_record = Todo.new(attributes_for(:todo))
        expect do
          new_record.save
        end.to change(Todo, :count).by 1
      end
    end

    context "when the object has an id already" do
      before(:all) do
        @new_record = Todo.create(attributes_for(:todo))
      end

      it " doesn't create a new record" do
        @new_record.title = "test"
        expect do
          @new_record.save
        end.to change(Todo, :count).by 0
      end
    end
  end
end
