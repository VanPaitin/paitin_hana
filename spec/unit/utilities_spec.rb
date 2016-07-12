require "spec_helper"

RSpec.describe "Utility Methods" do
  describe "#snake_case" do
    describe "it returns strings in the appropriate snake case" do
      it { expect("PersonController".snake_case).to eq "person_controller" }
      
      it { expect("Person".snake_case).to eq "person" }
      
      it { expect("Todo::Person".snake_case).to eq "todo/person" }
      
      it { expect("PERSONController".snake_case).to eq "person_controller" }
      
      it { expect("Person8Controller".snake_case).to eq "person8_controller" }
      
      it { expect("personcontroller".snake_case).to eq "personcontroller" }
      
      it { expect("person".snake_case).to eq "person" }
    end
  end

  describe "#camel_case" do
    describe "it returns strings in the appropriate camel case" do
      it { expect("person_controller".camel_case).to eq "PersonController" }
      
      it { expect("person__todo_app".camel_case).to eq "PersonTodoApp" }
      
      it { expect("person".camel_case).to eq "Person" }
    end
  end

  describe "#pluralizes" do
    describe "it serves to pluralize any string passed to it" do
      it { expect("girl".pluralizes).to eq "girls" }
      
      it { expect("buzz".pluralizes).to eq "buzzes" }
      
      it { expect("story".pluralizes).to eq "stories" }
      
      it { expect("toy".pluralizes).to eq "toys" }
      
      it { expect("scarf".pluralizes).to eq "scarves" }
      
      it { expect("analysis".pluralizes).to eq "analyses" }
      
      it { expect("curriculum".pluralizes).to eq "curricula" }
      
      it { expect("criterion".pluralizes).to eq "criteria" }
      
      it { expect("amoeba".pluralizes).to eq "amoebae" }
      
      it { expect("focus".pluralizes).to eq "foci" }
      
      it { expect("bureau".pluralizes).to eq "bureaux" }
    end
  end
end
