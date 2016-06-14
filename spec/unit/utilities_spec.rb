require "spec_helper"

describe "Utility Methods" do
  context "#snake_case" do
    context "PersonController" do
      it { expect("PersonController".snake_case).to eq "person_controller" }
    end

    context "Person" do
      it { expect("Person".snake_case).to eq "person" }
    end

    context "Todo::Person" do
      it { expect("Todo::Person".snake_case).to eq "todo/person" }
    end

    context "PERSONController" do
      it { expect("PERSONController".snake_case).to eq "person_controller" }
    end

    context "Person8Controller" do
      it { expect("Person8Controller".snake_case).to eq "person8_controller" }
    end

    context "personcontroller" do
      it { expect("personcontroller".snake_case).to eq "personcontroller" }
    end

    context "person" do
      it { expect("person".snake_case).to eq "person" }
    end
  end

  context "#camel_case" do
    context "person_controller" do
      it { expect("person_controller".camel_case).to eq "PersonController" }
    end
    context "person__todo_app" do
      it { expect("person__todo_app".camel_case).to eq "PersonTodoApp" }
    end
    context "person" do
      it { expect("person".camel_case).to eq "Person" }
    end
  end

  context "#pluralize" do
    context "girl" do
      it { expect("girl".pluralize).to eq "girls" }
    end

    context "buzz" do
      it { expect("buzz".pluralize).to eq "buzzes" }
    end

    context "story" do
      it { expect("story".pluralize).to eq "stories" }
    end

    context "toy" do
      it { expect("toy".pluralize).to eq "toys" }
    end

    context "scarf" do
      it { expect("scarf".pluralize).to eq "scarves" }
    end

    context "analysis" do
      it { expect("analysis".pluralize).to eq "analyses" }
    end

    context "curriculum" do
      it { expect("curriculum".pluralize).to eq "curricula" }
    end

    context "criterion" do
      it { expect("criterion".pluralize).to eq "criteria" }
    end

    context "amoeba" do
      it { expect("amoeba".pluralize).to eq "amoebae" }
    end

    context "focus" do
      it { expect("focus".pluralize).to eq "foci" }
    end

    context "bureau" do
      it { expect("bureau".pluralize).to eq "bureaux" }
    end
  end
end