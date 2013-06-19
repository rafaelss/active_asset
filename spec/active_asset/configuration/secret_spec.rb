require "spec_helper"

describe ActiveAsset::Configuration, "#secret" do
  it "returns nil if it's not set" do
    expect(subject.secret).to eq(nil)
  end

  it "returns the set value" do
    subject.secret = "foo"
    expect(subject.secret).to eq("foo")
  end
end
