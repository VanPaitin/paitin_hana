require "spec_helper"

describe PaitinHana do
  it "has a version number" do
    expect(PaitinHana::VERSION).not_to be nil
  end
end

describe PaitinHana::Application do
  subject { PaitinHana::Application.new }

  it { is_expected.to respond_to(:call).with(1).argument }
end
