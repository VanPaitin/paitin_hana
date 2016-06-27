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

  context "#pluralizes" do
    context "girl" do
      it { expect("girl".pluralizes).to eq "girls" }
    end

    context "buzz" do
      it { expect("buzz".pluralizes).to eq "buzzes" }
    end

    context "story" do
      it { expect("story".pluralizes).to eq "stories" }
    end

    context "toy" do
      it { expect("toy".pluralizes).to eq "toys" }
    end

    context "scarf" do
      it { expect("scarf".pluralizes).to eq "scarves" }
    end

    context "analysis" do
      it { expect("analysis".pluralizes).to eq "analyses" }
    end

    context "curriculum" do
      it { expect("curriculum".pluralizes).to eq "curricula" }
    end

    context "criterion" do
      it { expect("criterion".pluralizes).to eq "criteria" }
    end

    context "amoeba" do
      it { expect("amoeba".pluralizes).to eq "amoebae" }
    end

    context "focus" do
      it { expect("focus".pluralizes).to eq "foci" }
    end

    context "bureau" do
      it { expect("bureau".pluralizes).to eq "bureaux" }
    end
  end
end
