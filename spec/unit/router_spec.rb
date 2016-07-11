require "spec_helper"

RSpec.describe PaitinHana::Routing::Router do
  before(:all) do
    @router = PaitinHana::Routing::Router.new
  end

  describe "a router instance" do
    subject { @router }

    it { is_expected.to respond_to(:get) }

    it { is_expected.to respond_to(:post) }

    it { is_expected.to respond_to(:put) }

    it { is_expected.to respond_to(:patch) }

    it { is_expected.to respond_to(:delete) }

    it { is_expected.to respond_to(:root) }
  end

  describe "#pattern_for" do
    let(:path) { "/routes" }

    describe "the nature of its return value" do
      it { expect(@router.pattern_for(path)).to be_a Array }

      it { expect(@router.pattern_for(path).length).to eql 2 }

      it { expect(@router.pattern_for(path)[0]).to be_a Regexp }

      it { expect(@router.pattern_for(path)[-1]).to be_a Array }
    end

    context "when there are no placeholders" do
      it "the placeholders array should be empty" do
        expect(@router.pattern_for(path)[-1]).to be_empty
      end
    end

    context "when there are placeholders" do
      it "the placeholders array should contain the placeholders" do
        expect(@router.pattern_for("/photos/:id")[-1]).to eql ["id"]
        expect(@router.pattern_for("/photos/:id/edit/:placeholders")[-1]).
          to eql ["id", "placeholders"]
      end
    end

    describe "the regex pattern generation" do
      it "should return the correct regex pattern" do
        regexp = %r{^/photos/(?<id>\w+)/edit$}
        expect(@router.pattern_for('/photos/:id/edit')[0]).to eql regexp
      end
    end

    it "should return the correct pattern and placeholders" do
      expect(@router.pattern_for("/photos/:id")).
        to eql [%r{^/photos/(?<id>\w+)$}, ["id"]]
    end
  end
end
